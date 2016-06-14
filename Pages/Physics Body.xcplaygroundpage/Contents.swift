/*:
 ### 물리엔진 적용하기
 - SKNode의 physicsBoby에 추가하면
   * SKScene.physicsWorld의 gravity에 의해서 아래로 떨어진다.
   * 디폴트 categoryBitMask와 collisionBitMask가 0xFFFFFFFF이기 때문에 충돌도 기본.
   * density, friction 등의 SKPhysicsBody 디폴트 속성도 적당한 값이 디폴트로 존재.
 */
import UIKit
import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        // Simulation 속도를 느리게 (디폴트는 1.0)
        self.physicsWorld.speed = 0.4

        let ball1 = SKShapeNode(circleOfRadius: 10)
        do {
            ball1.fillColor = [#Color(colorLiteralRed: 0.7540004253387451, green: 0, blue: 0.2649998068809509, alpha: 1)#]
            ball1.position = CGPointMake(158,400)

            ball1.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        }

        let ball2 = SKShapeNode(circleOfRadius: 10)
        do {
            ball2.fillColor = [#Color(colorLiteralRed: 0.9672742486000061, green: 0.8225458264350891, blue: 0.4772382378578186, alpha: 1)#]
            ball2.position = CGPointMake(160,200)

            ball2.physicsBody = SKPhysicsBody(circleOfRadius: 10)
            // 위치 고정 (회전은 가능)
            ball2.physicsBody?.pinned = true
        }
        addChild(ball1)
        addChild(ball2)
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

