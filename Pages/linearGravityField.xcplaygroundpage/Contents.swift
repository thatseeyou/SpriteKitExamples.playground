/*:
 ### linearGravityField
 - Field를 가운데에 추가한다.
 - Field의 영향 범위를 region으로 제한한다.
 */
import UIKit
import SpriteKit

class GameScene: SKScene {
    var contentCreated = false
    let pi:CGFloat = CGFloat(M_PI)

    override func didMove(to view: SKView) {
        if self.contentCreated != true {

            // distribute small physics bobies
            for x in 0...10 {
                for y in 0...15 {
                    let orgX:CGFloat = 10.0
                    let orgY:CGFloat = 15.0
                    addBall(CGPoint(x:orgX + 30.0 * CGFloat(x), y:orgY + 30.0 * CGFloat(y)), hue: CGFloat(x) / 10.0, saturation: CGFloat(y) / 15.0)
                }
            }

            // add field node
            do {
                let position = CGPoint(x: 160, y: 240)
                let radius:Float = 50.0

                let shapeNode = SKShapeNode(circleOfRadius: CGFloat(radius))
                shapeNode.position = position
                addChild(shapeNode)

                let field = SKFieldNode.linearGravityField(withVector: vector_float3(0.0, 9.0, 1.0))
                field.position = position

                field.region = SKRegion(radius: radius)

                addChild(field)
            }

            self.physicsWorld.speed = 0.5
            self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)

            self.contentCreated = true
        }
    }

    func addBall(_ position:CGPoint, hue:CGFloat, saturation:CGFloat) {
        let radius = CGFloat(5.0)

        let ball = SKShapeNode(circleOfRadius: radius)
        ball.position = position

        ball.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        ball.physicsBody?.friction = 0.8
        ball.physicsBody?.mass = 1.0
        ball.physicsBody?.linearDamping = 0.5

        ball.strokeColor = UIColor.clear
        ball.fillColor = UIColor(hue: hue, saturation: saturation, brightness: 1.0, alpha: 1.0)

        addChild(ball)
    }
}


class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // add SKView
        do {
            let skView = SKView(frame:CGRect(x: 0, y: 0, width: 320, height: 480))
            skView.showsFPS = true
            //skView.showsNodeCount = true
            skView.showsFields = true
            skView.ignoresSiblingOrder = true

            let scene = GameScene(size: CGSize(width: 320, height: 480))
            scene.scaleMode = .aspectFit
            
            skView.presentScene(scene)
            self.view.addSubview(skView)
        }
    }
}

PlaygroundHelper.showViewController(ViewController())


