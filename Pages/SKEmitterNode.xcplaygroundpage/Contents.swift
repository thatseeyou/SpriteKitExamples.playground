/*:
 ### Particle file을 Xcode를 통해서 생성한 후에 읽을 수 있다.
 - Fire.sks 생성하기 : File/New/File에서 Resource/Particle File 선택에서 생성 후 끌어서 Resources 폴더에 놓으면 된다.
 */
import UIKit
import SpriteKit

class GameScene: SKScene {
    var contentCreated = false

    override func didMove(to view: SKView) {
        if self.contentCreated != true {
            let fireNode = SKEmitterNode(fileNamed: "Fire.sks")!
            fireNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            addChild(fireNode)

            self.contentCreated = true
        }
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

