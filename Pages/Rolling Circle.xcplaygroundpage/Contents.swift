/*:
 ### UIBezierPath를 이용해서 SKShapeNode를 만들 수 있다.
 */
import UIKit
import SpriteKit

class GameScene: SKScene {
    var contentCreated = false
    let pi:CGFloat = CGFloat(M_PI)

    override func didMove(to view: SKView) {
        if self.contentCreated != true {

            do {
                let shape = SKShapeNode(path: makeHalfCircle().cgPath)
                shape.strokeColor = SKColor.green
                shape.fillColor = SKColor.red
                shape.position = CGPoint(x: self.frame.midX, y: self.frame.midY)

                shape.physicsBody = SKPhysicsBody(polygonFrom: makeHalfCircle().cgPath)
                shape.physicsBody?.isDynamic = true
                shape.physicsBody?.pinned = true
                shape.physicsBody?.affectedByGravity = false
                shape.physicsBody?.friction = 1.0
                addChild(shape)

                shape.run(angularImpulse())
            }

            addBall(CGPoint(x: self.frame.midX, y: self.frame.midY))
            addBall(CGPoint(x: self.frame.midX - 40, y: self.frame.midY))
            addBall(CGPoint(x: self.frame.midX + 50, y: self.frame.midY))


            self.physicsWorld.speed = 0.2
            //self.physicsWorld.gravity = CGVectorMake(0, -9)

            self.contentCreated = true
        }
    }

    func addBall(_ position:CGPoint) {
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
        bezierPath.move(to: CGPoint(x: 110.0, y: 0.0))
        bezierPath.addArc(withCenter: CGPoint(x: 0.0, y: 0.0), radius: 100.0, startAngle: 2.0 * pi, endAngle: pi, clockwise: false)
        //bezierPath.addLineToPoint(CGPointMake(110, 0.0))
        bezierPath.addArc(withCenter: CGPoint(x: 0.0, y: 0.0), radius: 110.0, startAngle: pi, endAngle: 2.0 * pi, clockwise: true)
        bezierPath.close()

        return bezierPath
    }

    func angularImpulse() -> SKAction {

        let waitAction = SKAction.wait(forDuration: 2.0)
        let impulse = SKAction.applyAngularImpulse(0.3, duration: 1.0)
        let all = SKAction.sequence([waitAction, impulse])

        return all
    }

    func rotation() -> SKAction {

        let waitAction = SKAction.wait(forDuration: 2.0)
        let rotate = SKAction.rotate(byAngle: pi * 0.25, duration: 1.0)
        let revereRotate = rotate.reversed()
        let rocking = SKAction.sequence([rotate, revereRotate])
        let repeatAction = SKAction.repeatForever(rocking)

        let all = SKAction.sequence([waitAction, repeatAction])

        return all
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
            skView.ignoresSiblingOrder = true

            let scene = GameScene(size: CGSize(width: 320, height: 480))
            scene.scaleMode = .aspectFit

            skView.presentScene(scene)
            self.view.addSubview(skView)
        }
    }
}

PlaygroundHelper.showViewController(ViewController())


