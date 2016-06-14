/*:
 ### PhysicsBody 안에 가두기
 - Edge collider는 mass가 없기 때문에 원하는 효과를 주기 어려운 경우가 있다.
 - 안이 비어있는 physics body를 만들 수는 없기 때문에 휘어서 가두었다.
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

            do {
                let picker = SKShapeNode(rect: CGRectMake(-10.0, -30.0, 20.0, 60.0))
                picker.position = CGPointMake(self.frame.midX, self.frame.midY - 100.0)
                picker.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(20.0, 60.0))
                picker.physicsBody?.affectedByGravity = false

                addChild(picker)
            }

            addBall(CGPointMake(self.frame.midX, self.frame.midY))
            addBall(CGPointMake(self.frame.midX - 40, self.frame.midY))
            addBall(CGPointMake(self.frame.midX + 50, self.frame.midY))


            self.physicsWorld.speed = 0.5
            //self.physicsWorld.gravity = CGVectorMake(0, -9)

            self.contentCreated = true
        }
    }

    func addBall(position:CGPoint) {
        let radius = CGFloat(20.0)

        let ball = SKShapeNode(circleOfRadius: radius)
        ball.position = position

        ball.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        ball.physicsBody?.friction = 0.5
        ball.physicsBody?.density = 0.2

        addChild(ball)

        let label = SKLabelNode(text: "45")
        label.fontSize = 18.0
        label.position = CGPointMake( 0.0, 0.0)
        label.verticalAlignmentMode = .Center
//        CGRectGetMidX(ball.bounds),
//                                      CGRectGetMidY(ball.bounds));

        ball.addChild(label)
    }

    func makeHalfCircle() -> UIBezierPath {
        // CGPath가 되면 X축을 중심으로 flipping
        // physicsBody에 사용하기 위해서는 counter clockwise가 되도록 하는 것이 좋다. (bezierPathByReversingPath를 사용해서 변경하는 것도 가능하다.)
        let bezierPath = UIBezierPath()
        let innerRadius = CGFloat(100.0)
        let outerRadius = innerRadius + 10.0
        let startAngle = 0.0 * pi;
        let endAngle = 0.0001 * pi;
        let startPoint = CGPointMake(innerRadius * cos(startAngle), innerRadius * sin(startAngle))


        bezierPath.moveToPoint(startPoint)
        // inner circle
        bezierPath.addArcWithCenter(CGPointMake(0.0, 0.0), radius: innerRadius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        //bezierPath.addLineToPoint(CGPointMake(110, 0.0))
        // outer circle
        bezierPath.addArcWithCenter(CGPointMake(0.0, 0.0), radius: outerRadius
, startAngle: endAngle, endAngle: startAngle, clockwise: true)
        bezierPath.closePath()

        return bezierPath
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


