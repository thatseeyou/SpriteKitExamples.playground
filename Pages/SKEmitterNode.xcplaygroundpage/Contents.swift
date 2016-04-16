/*:
 # 
 - Fire.sks 생성하기 : File/New/File에서 Resource/Particle File 선택에서 생성 후 끌어서 Resources 폴더에 놓으면 된다.
 */
import UIKit
import SpriteKit

class GameScene: SKScene {
    var contentCreated = false

    override func didMoveToView(view: SKView) {
        if self.contentCreated != true {
            let fireNode = SKEmitterNode(fileNamed: "Fire.sks")!
            fireNode.position = CGPointMake(self.frame.midX, self.frame.midY)
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

