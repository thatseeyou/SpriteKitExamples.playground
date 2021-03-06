/*:
 ### 2개의 SKView, 1개의 UIView(UILabel)가 동시에 화면에 표시된다.
 - SKView도 UIView
 - SKView는 UIImageView와 같이 view hierarchy를 구성하게 된다.
 - SKView와 SKScene의 크기가 다르기 때문에 scaleMode에 따른 확대/축소가 발생하고 넘치거나 부족한 경우가 발생할 수도 있다.
 */
import UIKit
import SpriteKit

class GameScene: SKScene {
    var text:String!
    var gameScore:SKLabelNode!
    var contentCreated = false

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(size: CGSize, text: String) {
        super.init(size: size)
        self.text = text
    }

    override func didMove(to view: SKView) {
        if self.contentCreated != true {
            self.gameScore = SKLabelNode(text: self.text)
            self.gameScore.position = CGPoint(x: 8, y: 8)
            self.gameScore.horizontalAlignmentMode = .left
            self.gameScore.fontSize = 48
            addChild(self.gameScore)
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

            let scene = GameScene(size: CGSize(width: 300,height: 300), text: "Scene1")
            scene.scaleMode = .aspectFit

            skView.presentScene(scene)
            self.view.addSubview(skView)
        }

        // add SKView
        do {
            let skView = SKView(frame:CGRect(x: 0, y: 0, width: 200, height: 180))
            skView.showsFPS = true
            //skView.showsNodeCount = true
            skView.ignoresSiblingOrder = true

            let scene = GameScene(size: CGSize(width: 200,height: 200), text: "Scene2")
            scene.scaleMode = .aspectFill

            skView.presentScene(scene)
            self.view.addSubview(skView)
        }

        // add UIView
        do {
            let label = UILabel(frame:CGRect(x: 100,y: 100,width: 10,height: 10))
            label.text = "I'm UILabel"
            label.textColor = #colorLiteral(red: 0.8949507474899292, green: 0.1438436359167099, blue: 0.08480125665664673, alpha: 1)
            label.sizeToFit()

            self.view.addSubview(label)
        }
    }
}

PlaygroundHelper.showViewController(ViewController())

