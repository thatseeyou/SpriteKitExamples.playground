/*:
 ### Scene editor를 이용해서 node tree 구성
 - SKNode의 init(fileNamed:) 메소드를 통해서 scene의 설정, 포함하는 node 및 설정을 포함하는 sks 파일을 읽어들일 수 있다.
 - Xcode 7.3까지는 아직 기능이 불안하고 불안정하다.
 */
import UIKit
import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        // Simulation 속도를 느리게 (디폴트는 1.0)
        self.physicsWorld.speed = 0.4
    }
}


class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = SKView(frame:CGRectMake(0, 0, 320, 480))
            skView.showsFPS = true
            skView.showsNodeCount = true

            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true

            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFit

            skView.presentScene(scene)
            self.view.addSubview(skView)
        }

    }
}

PlaygroundHelper.showViewController(ViewController())

