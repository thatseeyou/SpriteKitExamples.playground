/*:
 ### Fragment shader를 적용해 보자.
 - shader_bw.fsh는 색을 gray scale로 변환한다.
 - 참고 : https://github.com/mdejong/SKShaderBWWindow
 - Add fillShader to the node randomly selected.
 */
import UIKit
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    let bwShader = SKShader(fileNamed: "shader_bw.fsh")

    override func didMove(to view: SKView) {
        // distribute small physics bobies
        for x in 0...10 {
            for y in 0...15 {
                let orgX:CGFloat = 10.0
                let orgY:CGFloat = 15.0
                let random = GKRandomSource.sharedRandom().nextInt(upperBound: 2)

                let bShader = random > 0 ? true : false

                addBall(CGPoint(x:orgX + 30.0 * CGFloat(x), y:orgY + 30.0 * CGFloat(y)), hue: CGFloat(x) / 10.0, saturation: CGFloat(y) / 15.0, bShader: bShader)
            }
        }

        self.physicsWorld.speed = 0.5
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)

    }

    func addBall(_ position:CGPoint, hue:CGFloat, saturation:CGFloat, bShader:Bool) {
        let radius = CGFloat(5.0)

        let ball = SKShapeNode(circleOfRadius: radius)
        ball.position = position

        ball.physicsBody = SKPhysicsBody(circleOfRadius: radius)

        let color = UIColor(hue: hue, saturation: saturation, brightness: 1.0, alpha: 1.0)
        ball.strokeColor = color
        ball.fillColor = color

        if bShader == true {
            ball.fillShader = self.bwShader
        }

        addChild(ball)
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


