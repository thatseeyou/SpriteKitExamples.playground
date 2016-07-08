/*:
 ### dragField
 - physicsWorld.gravity에 맞서는 것을 확인할 수 있다.
 - 속도가 점점 커지지만 dragField 안에서는 일종 속도가 유지되는 것을 확인할 수 있다.
 - field.region을 없애고 ball.physicsBody의 velocity를 관찰하면 알 수 있다.
 */
import UIKit
import SpriteKit

class GameScene: SKScene {
    var contentCreated = false
    let pi:CGFloat = CGFloat(M_PI)

    override func didMoveToView(view: SKView) {
        if self.contentCreated != true {

            // distribute small physics bobies
            for x in 0...10 {
                for y in (0...15).reverse() {
                    let orgX:CGFloat = 10.0
                    let orgY:CGFloat = 15.0
                    addBall(
                        CGPoint(
                            x:orgX + 30.0 * CGFloat(x),
                            y:orgY + 30.0 * CGFloat(y)
                        ),
                        hue: CGFloat(x) / 10.0,
                        saturation: CGFloat(y) / 15.0)
                }
            }

            // add dragField node
            do {
                let position = CGPoint(x: 160, y: 120)
                let radius:Float = 50.0

                let shapeNode = SKShapeNode(circleOfRadius: CGFloat(radius))
                shapeNode.position = position
                addChild(shapeNode)

                let field = SKFieldNode.dragField()
                field.strength = 100.0 // default = 1
                field.position = position

                field.region = SKRegion(radius: radius)

                addChild(field)

            }

            self.physicsWorld.speed = 0.5
            self.physicsWorld.gravity = CGVectorMake(0, -9.0)

            self.contentCreated = true
        }
    }

    override func update(currentTime: NSTimeInterval) {
        // Only first ball returned
        let ball = childNodeWithName("Ball")
        -(ball!.physicsBody!.velocity.dy)
    }

    func addBall(position:CGPoint, hue:CGFloat, saturation:CGFloat) {
        let radius = CGFloat(5.0)

        let ball = SKShapeNode(circleOfRadius: radius)
        ball.name = "Ball"
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
            skView.showsFields = true
            skView.ignoresSiblingOrder = true

            let scene = GameScene(size: CGSizeMake(320, 480))
            scene.scaleMode = .AspectFit

            skView.presentScene(scene)
            self.view.addSubview(skView)
        }
    }
}

PlaygroundHelper.showViewController(ViewController())


