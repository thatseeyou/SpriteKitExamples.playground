/*:
 ### UIBezierPath를 이용해서 SKShapeNode를 만들 수 있다.
 */
import UIKit
import SpriteKit

class GameScene: SKScene {
    var contentCreated = false
    let pi:CGFloat = CGFloat(M_PI)

    override func didMoveToView(view: SKView) {
        if self.contentCreated != true {

            do {
                let shape = SKShapeNode(path: makeHalfCircle().CGPath)
                shape.strokeColor = SKColor.greenColor()
                shape.fillColor = SKColor.redColor()
                shape.position = CGPointMake(self.frame.midX, self.frame.midY)

                shape.physicsBody = SKPhysicsBody(polygonFromPath: makeHalfCircle().CGPath)
                shape.physicsBody?.dynamic = true
                shape.physicsBody?.pinned = true
                shape.physicsBody?.affectedByGravity = false
                shape.physicsBody?.friction = 1.0
                addChild(shape)

                shape.runAction(angularImpulse())
            }

            addBall(CGPointMake(self.frame.midX, self.frame.midY))
            addBall(CGPointMake(self.frame.midX - 40, self.frame.midY))
            addBall(CGPointMake(self.frame.midX + 50, self.frame.midY))


            self.physicsWorld.speed = 0.2
            //self.physicsWorld.gravity = CGVectorMake(0, -9)

            self.contentCreated = true
        }
    }

    func addBall(position:CGPoint) {
        let ball = SKShapeNode(circleOfRadius: 10.0)
        ball.position = position

        ball.physicsBody = SKPhysicsBody(circleOfRadius: 10.0)
        ball.physicsBody?.friction = 1.0
        ball.physicsBody?.density = 0.1

        addChild(ball)

        let label = SKLabelNode(text: "45")
        ball.addChild(label)
    }

    func makeHalfCircle() -> UIBezierPath {
        // CGPath가 되면 X축을 중심으로 flipping
        // physicsBody에 사용하기 위해서는 clockwise가 되도록 하는 것이 좋다. Flipping이 되면서 counter clockwise가 된다.
        // bezierPathByReversingPath를 사용해서 변경하는 것도 가능하다.
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(110.0, 0.0))
        bezierPath.addArcWithCenter(CGPointMake(0.0, 0.0), radius: 100.0, startAngle: 2.0 * pi, endAngle: pi, clockwise: false)
        //bezierPath.addLineToPoint(CGPointMake(110, 0.0))
        bezierPath.addArcWithCenter(CGPointMake(0.0, 0.0), radius: 110.0, startAngle: pi, endAngle: 2.0 * pi, clockwise: true)
        bezierPath.closePath()

        return bezierPath
    }

    func angularImpulse() -> SKAction {

        let waitAction = SKAction.waitForDuration(2.0)
        let impulse = SKAction.applyAngularImpulse(0.3, duration: 1.0)
        let all = SKAction.sequence([waitAction, impulse])

        return all
    }

    func rotation() -> SKAction {

        let waitAction = SKAction.waitForDuration(2.0)
        let rotate = SKAction.rotateByAngle(pi * 0.25, duration: 1.0)
        let revereRotate = rotate.reversedAction()
        let rocking = SKAction.sequence([rotate, revereRotate])
        let repeatAction = SKAction.repeatActionForever(rocking)

        let all = SKAction.sequence([waitAction, repeatAction])

        return all
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


