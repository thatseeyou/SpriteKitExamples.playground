/*:
 ### SKScene이 전환이 될 때 효과를 줄 수 있다.
 */
import UIKit
import SpriteKit

class Scene1: SKScene {
    var contentCreated = false

    override func didMove(to view: SKView) {
        if self.contentCreated != true {
            self.backgroundColor = #colorLiteral(red: 1, green: 0.9999743700027466, blue: 0.9999912977218628, alpha: 1)

            let transitionNames = [
                "crossFadeWithDuration",
                "doorsCloseHorizontalWithDuration",
                "doorsCloseVerticalWithDuration",
                "doorsOpenHorizontalWithDuration",
                "doorsOpenVerticalWithDuration",
                "doorwayWithDuration",
                "fadeWithColor",
                "fadeWithDuration",
                "flipHorizontalWithDuration",
                "flipVerticalWithDuration",
                "moveInWithDirection",
                "pushWithDirection",
                "revealWithDirection",
                "transitionWithCIFilter"
            ]

            for (i, name) in transitionNames.enumerated() {
                let label = SKLabelNode(text: name)
                label.fontColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                label.fontSize = 25
                label.position = CGPoint(x: 160, y: CGFloat(i * 30) + 14)
                label.name = name
                addChild(label)
            }

            self.contentCreated = true
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodes = self.nodes(at: location)

            for node in nodes {
                guard node.name != nil else { continue }
            NotificationCenter.default.post(name: Notification.Name(rawValue: "transition"), object: self, userInfo: ["name": node.name!])
            }
        }
    }
}

class ViewController: UIViewController {
    override func loadView() {
        self.view = SKView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // add SKView
        do {
            let skView = self.view as! SKView
            skView.showsFPS = true
            //skView.showsNodeCount = true
            skView.ignoresSiblingOrder = true

            let scene = Scene1(size: CGSize(width: 320, height: 480))
            scene.scaleMode = .aspectFit

            skView.presentScene(scene)
        }

        addObservers()

    }

    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.transition(_:)), name: "transition", object: nil)
    }

    func transition(_ notification: Notification) {
        let transitionName = notification.userInfo!["name"] as! String
        print("\(transitionName)")

        var transition:SKTransition!

        switch transitionName {
        case "crossFadeWithDuration":
            transition = SKTransition.crossFade(withDuration: 3.0)
        case "doorsCloseHorizontalWithDuration":
            transition = SKTransition.doorsCloseHorizontal(withDuration: 3.0)
        case "doorsCloseVerticalWithDuration":
            transition = SKTransition.doorsCloseVertical(withDuration: 3.0)
        case "doorsOpenHorizontalWithDuration":
            transition = SKTransition.doorsOpenHorizontal(withDuration: 3.0)
        case "doorsOpenVerticalWithDuration":
            transition = SKTransition.doorsOpenVertical(withDuration: 3.0)
        case "doorwayWithDuration":
            transition = SKTransition.doorway(withDuration: 3.0)
        case "fadeWithColor":
            transition = SKTransition.fade(with: UIColor.green, duration: 3.0)
        case "fadeWithDuration":
            transition = SKTransition.fade(withDuration: 3.0)
        case "flipHorizontalWithDuration":
            transition = SKTransition.flipHorizontal(withDuration: 3.0)
        case "flipVerticalWithDuration":
            transition = SKTransition.flipVertical(withDuration: 3.0)
        case "moveInWithDirection":
            transition = SKTransition.moveIn(with: .down, duration: 3.0)
        case "pushWithDirection":
            transition = SKTransition.push(with: .up, duration: 3.0)
        case "revealWithDirection":
            transition = SKTransition.reveal(with: .left, duration: 3.0)
        case "transitionWithCIFilter":
            //transition = SKTransition.transition
            break

        default: break
        }

        transitionToNewScene(transition)
    }

    func transitionToNewScene(_ transition:SKTransition) {
        let skView = self.view as! SKView
        let scene = Scene1(size: CGSize(width: 320, height: 480))

        skView.presentScene(scene, transition: transition)
    }
}

PlaygroundHelper.showViewController(ViewController())
