import UIKit
import SpriteKit

class GameScene: SKScene {
    var contentCreated = false

    override func didMoveToView(view: SKView) {
        if self.contentCreated != true {
            let shape1 = SKShapeNode(path: makeBezierPath().CGPath)
            do {
                shape1.strokeColor = SKColor.greenColor()
                shape1.fillColor = SKColor.redColor()
                shape1.position = CGPointMake(self.frame.midX, self.frame.midY + 100)
            }

            let shape2 = shape1.copy() as! SKShapeNode
            do {
                shape2.position = CGPointMake(self.frame.midX, self.frame.midY - 100)
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

