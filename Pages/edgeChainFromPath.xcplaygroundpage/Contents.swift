/*:
 ### edgeChainFromPath를 사용해서 공 가두기
 */
import UIKit
import SpriteKit

class GameScene: SKScene {
    let pi:CGFloat = CGFloat(M_PI)

    override func didMoveToView(view: SKView) {
        
        do {
            let arc = arcPathWithRadius(100.0,
                                        startAngle: 85.0 * pi / 180.0,
                                        endAngle: 95.0 * pi / 180.0).CGPath
            let shape = SKShapeNode(path: arc)
            shape.position = CGPointMake(self.frame.midX, self.frame.midY)

            shape.physicsBody = SKPhysicsBody(
                edgeChainFromPath:arc)

            addChild(shape)
        }

        // distribute small physics bobies
        for x in 0...10 {
            for y in 0...15 {
                let orgX:CGFloat = 10.0
                let orgY:CGFloat = 15.0
                addBall(CGPoint(x:orgX + 30.0 * CGFloat(x), y:orgY + 30.0 * CGFloat(y)), hue: CGFloat(x) / 10.0, saturation: CGFloat(y) / 15.0)
            }
        }

        self.physicsWorld.speed = 0.5
        //self.physicsWorld.gravity = CGVectorMake(0, -9)

    }

    func arcPathWithRadius(radius:CGFloat, startAngle:CGFloat, endAngle:CGFloat) -> UIBezierPath {
        // CGPath가 되면 X축을 중심으로 flipping
        // physicsBody에 사용하기 위해서는 counter clockwise가 되도록 하는 것이 좋다. (bezierPathByReversingPath를 사용해서 변경하는 것도 가능하다.)
        let bezierPath = UIBezierPath()

        let startPoint = CGPointMake(radius * cos(startAngle), radius * sin(startAngle))
        bezierPath.moveToPoint(startPoint)
        bezierPath.addArcWithCenter(CGPointMake(0.0, 0.0), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)

        return bezierPath
    }

    func addBall(position:CGPoint, hue:CGFloat, saturation:CGFloat) {
        let radius = CGFloat(5.0)

        let ball = SKShapeNode(circleOfRadius: radius)
        ball.position = position

        ball.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        ball.physicsBody?.friction = 0.8
        ball.physicsBody?.mass = 1.0
        ball.physicsBody?.linearDamping = 0.5

        ball.strokeColor = UIColor.clearColor()
        ball.fillColor = UIColor(hue: hue, saturation: saturation, brightness: 1.0, alpha: 1.0)

        addChild(ball)
    }
}


class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // add SKView
        do {
            let skView = SKView(frame:CGRectMake(0, 0, 320, 480))
            skView.showsFPS = true
            //skView.showsNodeCount = true
            skView.ignoresSiblingOrder = true

            let scene = GameScene(size: CGSizeMake(320, 480))
            scene.scaleMode = .AspectFit
            
            skView.presentScene(scene)
            self.view.addSubview(skView)
        }
    }
}

PlaygroundHelper.showViewController(ViewController())


