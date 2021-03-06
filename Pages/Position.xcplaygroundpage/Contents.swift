/*:
 ### SKNode의 위치는 어떻게 결정되는가?
 #### properties
 - bounding box : Path나 이미지를 감싸고 있는 box. 명시적인 property로 존재하지는 않는다.
 - anchorPoint : bounding box내에서의 위치 잡는 기준점. (0,0) ~ (1.0, 1.0) 값을 같는다. SKSpriteNode 이외에는 별도의 property로 존재하지 않는다. (0,0) 아니면 (0.5, 0.5)가 기본.
 - position : AnchorPoint의 위치.
 - frame : bounding box의 anchorPoint를 position에 맞추면 결정되는 나의 위치와 크기. 기준은 부모 좌표 (read-only)
 
 #### SKShape의 anchorPoint
 - centered : true
     * bounding box를 계산 후 중심점을 anchorPoint로 계산한다.
     * shapeNodeWithPath:centered:true
     * shapeNodeWithCircleOfRadius
     * shapeNodeWithEllipseOfSize

 - centered : false
     * position을 원점으로 삼아서 그림을 그린다. anchorPoint도 (0,0)
 
 #### 회전의 중심
 - anchorPoint가 회전의 중심이 된다.
 - anchorPoint는 position에 위치하게 되므로 결국에는 position이 회전의 중심이 되는 것이다.
 
 ### 자식의 위치
 - 부모의 position이 자식 좌표의 원점이 된다. 부모의 centered가 true/false에 상관없이 position이 같다면 자식의 위치는 동일하게 된다.
 */
import UIKit
import SpriteKit

class GameScene: SKScene {
    var contentCreated = false

    func showGuide(_ distance:CGFloat) {
        let maxX = frame.maxX
        let maxY = frame.maxY

        let path = UIBezierPath()

        var y = distance
        repeat {
            path.move(to: CGPoint(x: 0, y: y))
            path.addLine(to: CGPoint(x: maxX, y: y))

            y += distance
        } while(y < maxY)

        var x = distance
        repeat {
            path.move(to: CGPoint(x: x, y: 0))
            path.addLine(to: CGPoint(x: x, y: maxY))

            x += distance
        } while(x < maxX)

        let shape = SKShapeNode(path: path.cgPath)
        addChild(shape)
    }

    func rectFromPath(parent: SKNode, position: CGPoint, rect:CGRect, centered: Bool, color:SKColor) -> SKNode
    {
        let path = UIBezierPath(rect: rect).cgPath

        let shape = SKShapeNode(path: path, centered: centered)
        shape.position = position
        shape.lineWidth = 0.0
        shape.fillColor = color

        parent.addChild(shape)

        return shape
    }

    func rectFromShape(parent: SKNode, position: CGPoint, rect:CGRect, color:SKColor) -> SKNode
    {
        let shape = SKShapeNode(rect: rect)
        shape.position = position
        shape.lineWidth = 0.0
        shape.fillColor = color

        parent.addChild(shape)

        return shape
    }
    
    func circle(parent: SKNode, position: CGPoint, radius:CGFloat, color:SKColor) -> SKNode
    {
        let shape = SKShapeNode(circleOfRadius: radius)
        shape.position = position
        shape.lineWidth = 0.0
        shape.fillColor = color

        parent.addChild(shape)

        return shape
    }

    override func didMove(to view: SKView) {
        let center = CGPoint(x: self.frame.midX, y: self.frame.midY)

        showGuide(50)

        do {
            let parent = rectFromPath(parent: self, position: center, rect: CGRect(x: 0,y: 0, width: 100, height: 100), centered: false, color: #colorLiteral(red: 0.7540004253387451, green: 0, blue: 0.2649998068809509, alpha: 0.5036368534482759))
            parent.frame
            parent.position

            let centerOfShape = CGPoint(x: parent.frame.width / 2.0, y: parent.frame.height / 2.0)
            let child = circle(parent: parent, position: centerOfShape, radius: 50.0, color: #colorLiteral(red: 0.1991284191608429, green: 0.6028449535369873, blue: 0.9592232704162598, alpha: 1))
            child.frame

            // 회전의 중심도 (0,0). 결국엔 positon
            let parentCopy = parent.copy() as? SKShapeNode
            parentCopy?.zRotation = 3.141592 * 45.0 / 180.0
            self.addChild(parentCopy!)
        }
        do {
            let parent = rectFromPath(parent: self, position: center, rect: CGRect(x: 0,y: 0, width: 100, height: 100), centered: true, color: #colorLiteral(red: 0.1431525945663452, green: 0.4145618975162506, blue: 0.7041897773742676, alpha: 0.5))
            parent.frame
            parent.position

            // 부모의 position이 자식의 위치를 결정하기 때문에 위의 centered:false 인 경우와 동일 위치에 원이 그려진다.
            let centerOfShape = CGPoint(x: parent.frame.width / 2.0, y: parent.frame.height / 2.0)
            let child = circle(parent: parent, position: centerOfShape, radius: 30.0, color: #colorLiteral(red: 1, green: 0.9999743700027466, blue: 0.9999912977218628, alpha: 1))
            child.frame

            // 회전의 중심도 center. 결국엔 position
            let parentCopy = parent.copy() as? SKShapeNode
            parentCopy?.zRotation = 3.141592 * 45.0 / 180.0
            self.addChild(parentCopy!)
        }
        do {
            // centered = true 인 경우에는 path의 위치가 중요하지 않다. 아래에서 (-200, -200)은 무시된다.
            let parent = rectFromPath(parent: self, position: center, rect: CGRect(x: -200, y: -200, width: 90, height: 90), centered: true, color: #colorLiteral(red: 0.6000000238418579, green: 0.4000000059604645, blue: 0.2000000029802322, alpha: 0.513604525862069))
            parent.frame
            parent.position
        }
        do {
            let parent = rectFromPath(parent: self, position: center, rect: CGRect(x: -40, y: -40, width: 80, height: 80), centered: false, color: #colorLiteral(red: 0, green: 1, blue: 0, alpha: 0.5))
            parent.frame
            parent.position
        }
        do {
            let parent = rectFromShape(parent: self, position: center, rect: CGRect(x: 10, y: 10, width: 70, height: 70), color: #colorLiteral(red: 1, green: 0.5, blue: 0, alpha: 0.5033405172413793))
            parent.frame
            parent.position
        }

        do {
            let centeredEllipse = SKShapeNode(ellipseOf: CGSize(width: 100, height: 50))
            centeredEllipse.position = CGPoint(x: 100, y: 100)
            addChild(centeredEllipse)

            let notCenteredEllipse = SKShapeNode(ellipseIn: CGRect(x: 0, y: 0, width: 100, height: 50))
            notCenteredEllipse.position = CGPoint(x: 100, y: 100)
            addChild(notCenteredEllipse)
        }
    }
}


class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // add SKView
        do {
            let skView = SKView(frame:CGRect(x: 0, y: 0, width: 320, height: 480))
            skView.showsFPS = true
            //skView.showsPhysics = true
            //skView.showsNodeCount = true
            skView.ignoresSiblingOrder = true

            let scene = GameScene(size: CGSize(width: 320, height: 480))
            scene.scaleMode = .aspectFit

            skView.presentScene(scene)
            self.view.addSubview(skView)
        }
    }
}

PlaygroundHelper.showViewController(ViewController())

