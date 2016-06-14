/*:
 ### 특점 지점에서의 폭파 효과
 참고 : iOS Swift Game Development Cookbook
 */
import UIKit
import SpriteKit

class GameScene: SKScene {
    var contentCreated = false
    let pi:CGFloat = CGFloat(M_PI)

    override func didMoveToView(view: SKView) {
        if self.contentCreated != true {
            // SKScene의 경계에 physicsbody 설정
            self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
            // Simulation 속도를 느리게 (디폴트는 1.0)
            self.physicsWorld.speed = 0.4


            for x in 0..<5 {
                for y in 0..<10 {
                    addBall(CGPointMake(CGFloat(160 + x * 11), CGFloat(y * 11)))
                    addBall(CGPointMake(CGFloat(160 - x * 11), CGFloat(y * 11)))
                }
            }

            Utility.runActionAfterTime(3) { () in
                self.applyExplosionAtPoint(CGPointMake(160, 0), radius: 100, power: 70)
            }

            self.contentCreated = true
        }
    }

    func addBall(position:CGPoint) {
        let ball = SKSpriteNode(color: [#Color(colorLiteralRed: 0.7540004253387451, green: 0, blue: 0.2649998068809509, alpha: 1)#], size: CGSizeMake(10,10))
        ball.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(10,10))

        ball.position = position
        ball.physicsBody!.density = 1

        addChild(ball)
    }

    func applyExplosionAtPoint(point: CGPoint,
                               radius:CGFloat, power:CGFloat) {
        // Work out which bodies are in range of the explosion // by creating a rectangle
        let explosionRect = CGRect(x: point.x - radius,
                                   y: point.y - radius,
                                   width: radius*2, height: radius*2)
        // For each body, apply an explosion force
        self.physicsWorld.enumerateBodiesInRect(explosionRect, usingBlock:{ (body, stop) in
            // Work out if the body has a node that we can use
            if let bodyPosition = body.node?.position {
                // Work out the direction that we should apply // the force in for this body
                let explosionOffset =
                    CGVector(dx: bodyPosition.x - point.x,
                        dy: bodyPosition.y - point.y)
                // Work out the distance from the explosion point
                let explosionDistance =
                    sqrt(explosionOffset.dx * explosionOffset.dx +
                        explosionOffset.dy * explosionOffset.dy)
                // Normalize the explosion force
                var explosionForce = explosionOffset
                explosionForce.dx /= explosionDistance
                explosionForce.dy /= explosionDistance
                // Multiply by explosion power
                explosionForce.dx *= power
                explosionForce.dy *= power
                // Finally, apply the force
                body.applyForce(explosionForce)
            }
        })
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
