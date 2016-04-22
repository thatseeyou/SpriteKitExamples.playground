/*:
 ### Edge에 physics body를 설정할 수 있다.
 - Scene의 경계에 physics body를 설정
 - Gravity의 영향을 받지 않게 설정
 - physicsWorld.speed를 이용해서 simulation 속도를 조절
 */
import UIKit
import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        // SKScene의 경계에 physicsbody 설정
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        //self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.speed = 2

        // Make ball
        let ball1 = ballWithRadius(10)
        do {
            ball1.fillColor = [#Color(colorLiteralRed: 0.7540004253387451, green: 0, blue: 0.2649998068809509, alpha: 1)#]
            ball1.position = CGPointMake(100,10)
            ball1.physicsBody?.velocity = CGVectorMake(100, 0)
        }

        let ball2 = ballWithRadius(20)
        do {
            ball2.fillColor = [#Color(colorLiteralRed: 0.2818343937397003, green: 0.5693024396896362, blue: 0.1281824260950089, alpha: 1)#]
            ball2.position = CGPointMake(100,100)
            ball2.physicsBody?.velocity = CGVectorMake(0, 100)
        }

        let ball3 = ballWithRadius(30)
        do {
            ball3.fillColor = [#Color(colorLiteralRed: 0.4120420813560486, green: 0.8022739887237549, blue: 0.9693969488143921, alpha: 1)#]
            ball3.position = CGPointMake(110,400)
            ball3.physicsBody?.velocity = CGVectorMake(0, -100)
        }

        addChild(ball1)
        addChild(ball2)
        addChild(ball3)
    }

    func ballWithRadius(radius:CGFloat) -> SKShapeNode {
        let ballShape = SKShapeNode(circleOfRadius: radius)
        do {
            ballShape.physicsBody = SKPhysicsBody(circleOfRadius: radius)
            ballShape.physicsBody?.allowsRotation = true
            ballShape.physicsBody?.affectedByGravity = false

            ballShape.physicsBody?.density = 1.0
            ballShape.physicsBody?.friction = 0.0
            ballShape.physicsBody?.angularDamping = 0
            ballShape.physicsBody?.linearDamping = 0
            ballShape.physicsBody?.restitution = 1.0
            ballShape.physicsBody?.velocity = CGVector(dx: 100, dy: 100)
            //ballShape.fillColor = [#Color(colorLiteralRed: 0.6637836694717407, green: 0.4033902585506439, blue: 0.08084951341152191, alpha: 1)#]
            //ballShape.position = CGPointMake(100,100)
        }

        let label = SKLabelNode(text: "\(radius)")
        do {
            label.fontSize = 10
        }

        ballShape.addChild(label)

        return ballShape
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

