/*:
 ### collision & contact test
 - collisionBitMask
     * bodyA.categoryBitMask & bodyB.collisionBitMask > 0 && bodyB.categoryBitMask & bodyA.collisionBitMask > 0
     * 짝충돌은 없다. 서로 충돌인 경우에만 충돌로 처리한다.
 - contactTestBitMask
     * bodyA.categoryBitMask & bodyB.contactTestBitMask > 0 || bodyB.categoryBitMask & bodyA.contactTestBitMask > 0
     * 한 쪽만 조건에 맞으면 가능하다.
     * 충돌이 없는 경우에는 test는 가능하다.
 */
import UIKit
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    override func didMoveToView(view: SKView) {
        self.name = "scene"
        // SKScene의 경계에 physicsbody 설정
        self.physicsWorld.gravity = CGVectorMake(0, -10)
        self.physicsWorld.speed = 0.3
        self.physicsWorld.contactDelegate = self

        // Test1. collision & test
        let ball1 = ballWithRadius(10)
        do {
            ball1.name = "ball1"
            ball1.fillColor = [#Color(colorLiteralRed: 0.7540004253387451, green: 0, blue: 0.2649998068809509, alpha: 1)#]
            ball1.position = CGPointMake(55,400)
            ball1.physicsBody?.categoryBitMask = 0x1
            ball1.physicsBody?.collisionBitMask = 0x10
            ball1.physicsBody?.contactTestBitMask = 0
        }
        let bar1 = barWithSize(CGSizeMake(100,10))
        do {
            bar1.name = "bar1"
            bar1.position = CGPointMake(55, 100)
            bar1.physicsBody?.categoryBitMask = 0x10
            bar1.physicsBody?.collisionBitMask = 0x1
            bar1.physicsBody?.contactTestBitMask = 0x1
        }

        // Test2. collision only
        let ball2 = ballWithRadius(20)
        do {
            ball2.name = "ball2"
            ball2.fillColor = [#Color(colorLiteralRed: 0.2818343937397003, green: 0.5693024396896362, blue: 0.1281824260950089, alpha: 1)#]
            ball2.position = CGPointMake(160,400)
            ball2.physicsBody?.categoryBitMask = 0x2
            ball2.physicsBody?.collisionBitMask = 0x20
            ball2.physicsBody?.contactTestBitMask = 0
        }
        let bar2 = barWithSize(CGSizeMake(100,10))
        do {
            bar2.name = "bar2"
            bar2.position = CGPointMake(160, 100)
            bar2.physicsBody?.categoryBitMask = 0x20
            bar2.physicsBody?.collisionBitMask = 0x2
            bar2.physicsBody?.contactTestBitMask = 0
        }

        // Test3. test only
        let ball3 = ballWithRadius(30)
        do {
            ball3.name = "ball3"
            ball3.fillColor = [#Color(colorLiteralRed: 0.4120420813560486, green: 0.8022739887237549, blue: 0.9693969488143921, alpha: 1)#]
            ball3.position = CGPointMake(265,400)
            ball3.physicsBody?.categoryBitMask = 0x4
            ball3.physicsBody?.collisionBitMask = 0
            ball3.physicsBody?.contactTestBitMask = 0
        }
        let bar3 = barWithSize(CGSizeMake(100,10))
        do {
            bar3.name = "bar3"
            bar3.position = CGPointMake(265, 100)
            bar3.physicsBody?.categoryBitMask = 0
            bar3.physicsBody?.collisionBitMask = 0
            bar3.physicsBody?.contactTestBitMask = 0x4
        }

        addChild(bar1)
        addChild(bar2)
        addChild(bar3)

        addChild(ball1)
        addChild(ball2)
        addChild(ball3)
    }

    func didBeginContact(contact: SKPhysicsContact) {
        print("START: \(contact.bodyA.node?.name) - \(contact.bodyB.node?.name)")
    }

    func didEndContact(contact: SKPhysicsContact) {
        print("END:   \(contact.bodyA.node?.name) - \(contact.bodyB.node?.name)")
    }

    func ballWithRadius(radius:CGFloat) -> SKShapeNode {
        let ballShape = SKShapeNode(circleOfRadius: radius)
        do {
            ballShape.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        }

        return ballShape
    }

    func barWithSize(size:CGSize) -> SKSpriteNode {
        let ballShape = SKSpriteNode(color: [#Color(colorLiteralRed: 0.3586547076702118, green: 0, blue: 0.1448745727539062, alpha: 1)#], size: size)
        do {
            ballShape.physicsBody = SKPhysicsBody(rectangleOfSize: size)
            ballShape.physicsBody?.dynamic = false
        }

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

