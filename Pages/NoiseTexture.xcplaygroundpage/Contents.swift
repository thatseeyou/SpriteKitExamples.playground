/*:
 ### Noise texture를 만들어 준다.
 */
import UIKit
import SpriteKit

class GameScene: SKScene {
    var contentCreated = false

    override func didMove(to view: SKView) {
        if self.contentCreated != true {
            // upper
            let noiseTexture = SKTexture(noiseWithSmoothness: 0.2, size: CGSize(width: 200, height: 200), grayscale: true)
            let node1 = SKSpriteNode(texture: noiseTexture)
            node1.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 100)
            addChild(node1)

            // lower
            let noiseTexture2 = SKTexture(noiseWithSmoothness: 0.2, size: CGSize(width: 200, height: 200), grayscale: false)
            let node2 = SKSpriteNode(texture: noiseTexture2)
            node2.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
            addChild(node2)

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

