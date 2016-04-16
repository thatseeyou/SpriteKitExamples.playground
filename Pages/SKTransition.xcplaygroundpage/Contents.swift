import UIKit
import SpriteKit

class Scene1: SKScene {
    var contentCreated = false

    override func didMoveToView(view: SKView) {
        if self.contentCreated != true {
            self.backgroundColor = [#Color(colorLiteralRed: 1, green: 0.9999743700027466, blue: 0.9999912977218628, alpha: 1)#]

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

            for (i, name) in transitionNames.enumerate() {
                let label = SKLabelNode(text: name)
                label.fontColor = [#Color(colorLiteralRed: 0, green: 0, blue: 0, alpha: 1)#]
                label.fontSize = 25
                label.position = CGPointMake(160, CGFloat(i * 30) + 14)
                label.name = name
                addChild(label)
            }

            self.contentCreated = true
        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            let nodes = nodesAtPoint(location)

            for node in nodes {
                guard node.name != nil else { continue }
            NSNotificationCenter.defaultCenter().postNotificationName("transition", object: self, userInfo: ["name": node.name!])
            }
        }
    }
}

class ViewController: UIViewController {
    override func loadView() {
        self.view = SKView(frame: CGRectMake(0, 0, 320, 480))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // add SKView
        do {
            let skView = self.view as! SKView
            skView.showsFPS = true
            //skView.showsNodeCount = true
            skView.ignoresSiblingOrder = true

            let scene = Scene1(size: CGSizeMake(320, 480))
            scene.scaleMode = .AspectFit

            skView.presentScene(scene)
        }

        addObservers()

    }

    func addObservers() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.transition(_:)), name: "transition", object: nil)
    }

    func transition(notification: NSNotification) {
        let transitionName = notification.userInfo!["name"] as! String
        print("\(transitionName)")

        var transition:SKTransition!

        switch transitionName {
        case "crossFadeWithDuration":
            transition = SKTransition.crossFadeWithDuration(3.0)
        case "doorsCloseHorizontalWithDuration":
            transition = SKTransition.doorsCloseHorizontalWithDuration(3.0)
        case "doorsCloseVerticalWithDuration":
            transition = SKTransition.doorsCloseVerticalWithDuration(3.0)
        case "doorsOpenHorizontalWithDuration":
            transition = SKTransition.doorsOpenHorizontalWithDuration(3.0)
        case "doorsOpenVerticalWithDuration":
            transition = SKTransition.doorsOpenVerticalWithDuration(3.0)
        case "doorwayWithDuration":
            transition = SKTransition.doorwayWithDuration(3.0)
        case "fadeWithColor":
            transition = SKTransition.fadeWithColor(UIColor.greenColor(), duration: 3.0)
        case "fadeWithDuration":
            transition = SKTransition.fadeWithDuration(3.0)
        case "flipHorizontalWithDuration":
            transition = SKTransition.flipHorizontalWithDuration(3.0)
        case "flipVerticalWithDuration":
            transition = SKTransition.flipVerticalWithDuration(3.0)
        case "moveInWithDirection":
            transition = SKTransition.moveInWithDirection(.Down, duration: 3.0)
        case "pushWithDirection":
            transition = SKTransition.pushWithDirection(.Up, duration: 3.0)
        case "revealWithDirection":
            transition = SKTransition.revealWithDirection(.Left, duration: 3.0)
        case "transitionWithCIFilter":
            //transition = SKTransition.transition
            break

        default: break
        }

        transitionToNewScene(transition)
    }

    func transitionToNewScene(transition:SKTransition) {
        let skView = self.view as! SKView
        let scene = Scene1(size: CGSizeMake(320, 480))

        skView.presentScene(scene, transition: transition)
    }
}

PlaygroundHelper.showViewController(ViewController())