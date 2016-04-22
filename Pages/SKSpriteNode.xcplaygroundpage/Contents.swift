/*:
 ### SKView 크기에 맞는 SKScene을 추가한다.
 - SKSpriteNode를 이용해서 사각형을 만든다.
 */
import UIKit
import SpriteKit

class GameScene: SKScene {
    var contentCreated = false

    override func didMoveToView(view: SKView) {
        if self.contentCreated != true {
            let sprite = SKSpriteNode(color: [#Color(colorLiteralRed: 0.4931360483169556, green: 0, blue: 0.1765155345201492, alpha: 1)#], size: CGSizeMake(100, 100))
            sprite.position = CGPointMake(100, 100)
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

