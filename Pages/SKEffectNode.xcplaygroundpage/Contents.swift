/*:
 ### SKEffectNode의 자식들에게 CIFilter를 적용할 수 있다.
 */
import UIKit
import SpriteKit

class GameScene: SKScene {
    var contentCreated = false

    override func didMove(to view: SKView) {
        if self.contentCreated != true {
            let shape1 = SKShapeNode(path: makeBezierPath().cgPath)
            do {
                shape1.strokeColor = SKColor.green
                shape1.fillColor = SKColor.red
                shape1.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 100)
            }

            let shape2 = shape1.copy() as! SKShapeNode
            do {
                shape2.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
            }

            let effect = SKEffectNode()
            do {
                let filter = CIFilter(name: "CIGaussianBlur")
                filter!.setValue(20.0, forKey:"inputRadius")

                effect.filter = filter
            }

            addChild(shape1)
            effect.addChild(shape2)
            addChild(effect)

            self.contentCreated = true
        }
    }

    func makeBezierPath() -> UIBezierPath {
        let path = UIBezierPath(roundedRect: CGRect(x: -50, y: -50, width: 100, height: 100), cornerRadius: 10)

        return path

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

