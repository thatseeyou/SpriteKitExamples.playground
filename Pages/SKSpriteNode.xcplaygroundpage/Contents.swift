/*:
 ### SKView 크기에 맞는 SKScene을 추가한다.
 - SKSpriteNode를 이용해서 사각형을 만든다.
 */
import UIKit
import SpriteKit

class GameScene: SKScene {
    var contentCreated = false

    override func didMove(to view: SKView) {
        if self.contentCreated != true {
            let sprite = SKSpriteNode(color: #colorLiteral(red: 0.4931360483169556, green: 0, blue: 0.1765155345201492, alpha: 1), size: CGSize(width: 100, height: 100))
            sprite.position = CGPoint(x: 100, y: 100)
            addChild(sprite)

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

