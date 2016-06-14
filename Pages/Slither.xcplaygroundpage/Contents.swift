/*:
 ### Joint 예제
 * 
 */
import UIKit
import SpriteKit

class GameScene: SKScene {
    var contentCreated = false
    let pi:CGFloat = CGFloat(M_PI)

    override func didMoveToView(view: SKView) {
        if self.contentCreated != true {
            self.physicsWorld.speed = 1.0
            self.physicsWorld.gravity = CGVectorMake(0, 0)

            var prevNode : SKNode?
            for i in 0..<10 {
                let currentNode = addBall(CGPointMake(40 + 20 * CGFloat(i), 240))

                if let prevNode = prevNode {
                    // anchorA, anchorB의 좌표는 scene이 된다.
                    let limitJoint = SKPhysicsJointLimit.jointWithBodyA(prevNode.physicsBody!, bodyB: currentNode.physicsBody!, anchorA: prevNode.position, anchorB: currentNode.position)
                    limitJoint.maxLength = 30.0

                    self.physicsWorld.addJoint(limitJoint)
                }

                prevNode = currentNode
            }

            // 마지막 노드 1개에만 힘을 가한다.
            prevNode?.physicsBody?.applyForce(CGVectorMake(0, -9.8))

//            let head = prevNode as! SKShapeNode
//            do {
//                head.name = "head"
//                head.strokeColor = [#Color(colorLiteralRed: 0.7540004253387451, green: 0, blue: 0.2649998068809509, alpha: 1)#]
//                head.position = CGPointMake(280, 100)
//            }

            self.contentCreated = true
        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            let nodes = nodesAtPoint(location)

            for node in nodes {
                if node.name == "head" {
                }
            }
        }
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {

        }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            let nodes = nodesAtPoint(location)

            for node in nodes {
                if node.name == "head" {
                }
            }
        }
    }


    func addBall(position:CGPoint) -> SKNode {
        let radius = CGFloat(20.0)

        let ball = SKShapeNode(circleOfRadius: radius)
        ball.position = position

        ball.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        ball.physicsBody?.categoryBitMask = 0x1
        ball.physicsBody?.collisionBitMask = 0x2

        addChild(ball)

        return ball
    }

    func angularImpulse() -> SKAction {
        let waitAction = SKAction.waitForDuration(2.0)
        let impulse = SKAction.applyAngularImpulse(0.7, duration: 3.0)
        let delayImpulse = SKAction.sequence([waitAction, impulse])

        return delayImpulse
    }
}


class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = GameScene(size: CGSizeMake(320, 480))
        do {
            scene.scaleMode = .AspectFit
        }

        let skView = SKView(frame:CGRectMake(0, 0, 320, 480))
        do {
            skView.showsFPS = true
            //skView.showsNodeCount = true
            skView.ignoresSiblingOrder = true
            skView.presentScene(scene)
        }

        self.view.addSubview(skView)
    }
}

PlaygroundHelper.showViewController(ViewController())


