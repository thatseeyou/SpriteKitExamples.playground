/*:
 ### UIBezierPath를 이용해서 SKShapeNode를 만들 수 있다.
 */
import UIKit
import SpriteKit

class GameScene: SKScene {
    var contentCreated = false

    override func didMove(to view: SKView) {
        if self.contentCreated != true {

            let shape = SKShapeNode(path: makeBezierPath().cgPath)
            shape.strokeColor = SKColor.green
            shape.fillColor = SKColor.red
            shape.position = CGPoint(x: self.frame.midX, y: self.frame.midY)

            addChild(shape)

            self.contentCreated = true
        }
    }

    func makeBezierPath() -> UIBezierPath {
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 26.5, y: 3.5))
        bezierPath.addCurve(to: CGPoint(x: 45.5, y: 21.5), controlPoint1: CGPoint(x: 18.21, y: -1.33), controlPoint2: CGPoint(x: 58.09, y: 18.38))
        bezierPath.addCurve(to: CGPoint(x: -18.5, y: 39.5), controlPoint1: CGPoint(x: 39.21, y: 23.06), controlPoint2: CGPoint(x: -14.26, y: 38.35))
        bezierPath.addCurve(to: CGPoint(x: -18.5, y: 21.5), controlPoint1: CGPoint(x: -37.39, y: 44.62), controlPoint2: CGPoint(x: 5.5, y: 27.5))
        bezierPath.addLine(to: CGPoint(x: -50.05, y: 10.11))
        bezierPath.addCurve(to: CGPoint(x: -27.34, y: -25.5), controlPoint1: CGPoint(x: -48.7, y: -15.86), controlPoint2: CGPoint(x: -45.79, y: -20.5))
        bezierPath.addCurve(to: CGPoint(x: 5.02, y: -33.21), controlPoint1: CGPoint(x: -23.12, y: -26.64), controlPoint2: CGPoint(x: -1.28, y: -31.65))
        bezierPath.addCurve(to: CGPoint(x: 50.98, y: -12.45), controlPoint1: CGPoint(x: 27.89, y: -38.88), controlPoint2: CGPoint(x: 42.61, y: -30.3))
        bezierPath.addCurve(to: CGPoint(x: 56, y: 3.07), controlPoint1: CGPoint(x: 53.3, y: -7.52), controlPoint2: CGPoint(x: 54.93, y: -2.22))
        bezierPath.addCurve(to: CGPoint(x: 56.85, y: 8.19), controlPoint1: CGPoint(x: 56.38, y: 4.92), controlPoint2: CGPoint(x: 56.66, y: 6.64))
        bezierPath.addCurve(to: CGPoint(x: 57.01, y: 9.62), controlPoint1: CGPoint(x: 56.92, y: 8.73), controlPoint2: CGPoint(x: 56.97, y: 9.2))
        bezierPath.addCurve(to: CGPoint(x: 57.05, y: 10.11), controlPoint1: CGPoint(x: 57.03, y: 9.86), controlPoint2: CGPoint(x: 57.05, y: 10.03))
        bezierPath.addCurve(to: CGPoint(x: 57, y: 10.41), controlPoint1: CGPoint(x: 57.05, y: 10.1), controlPoint2: CGPoint(x: 57.03, y: 10.22))
        bezierPath.addCurve(to: CGPoint(x: 56.77, y: 11.49), controlPoint1: CGPoint(x: 56.95, y: 10.72), controlPoint2: CGPoint(x: 56.88, y: 11.08))
        bezierPath.addCurve(to: CGPoint(x: 55.28, y: 15.41), controlPoint1: CGPoint(x: 56.47, y: 12.67), controlPoint2: CGPoint(x: 55.99, y: 13.99))
        bezierPath.addCurve(to: CGPoint(x: -35.5, y: -17.5), controlPoint1: CGPoint(x: 53.26, y: 19.49), controlPoint2: CGPoint(x: -30.41, y: -21.33))
        bezierPath.addCurve(to: CGPoint(x: 4.83, y: 42.2), controlPoint1: CGPoint(x: -44.38, y: -10.82), controlPoint2: CGPoint(x: 22.82, y: 39.23))
        bezierPath.addCurve(to: CGPoint(x: 26.5, y: -17.5), controlPoint1: CGPoint(x: -13.55, y: 45.23), controlPoint2: CGPoint(x: 35.15, y: -12.72))
        bezierPath.addCurve(to: CGPoint(x: -48.22, y: 21.17), controlPoint1: CGPoint(x: 19.52, y: -21.36), controlPoint2: CGPoint(x: -46.12, y: 29.43))
        bezierPath.addCurve(to: CGPoint(x: -50.06, y: 10.03), controlPoint1: CGPoint(x: -49.02, y: 18), controlPoint2: CGPoint(x: -49.4, y: 15.52))
        bezierPath.addLine(to: CGPoint(x: -51, y: 10.14))
        bezierPath.addCurve(to: CGPoint(x: -49.14, y: 21.39), controlPoint1: CGPoint(x: -50.33, y: 15.67), controlPoint2: CGPoint(x: -49.95, y: 18.17))
        bezierPath.addCurve(to: CGPoint(x: -35.67, y: 40.07), controlPoint1: CGPoint(x: -46.99, y: 29.88), controlPoint2: CGPoint(x: -42.91, y: 36.07))
        bezierPath.addCurve(to: CGPoint(x: 4.98, y: 43.12), controlPoint1: CGPoint(x: -26.81, y: 44.97), controlPoint2: CGPoint(x: -13.58, y: 46.18))
        bezierPath.addCurve(to: CGPoint(x: 45.35, y: 28.15), controlPoint1: CGPoint(x: 23.12, y: 40.12), controlPoint2: CGPoint(x: 36.34, y: 34.93))
        bezierPath.addCurve(to: CGPoint(x: 56.13, y: 15.82), controlPoint1: CGPoint(x: 50.56, y: 24.23), controlPoint2: CGPoint(x: 54.04, y: 20.03))
        bezierPath.addCurve(to: CGPoint(x: 57.69, y: 11.72), controlPoint1: CGPoint(x: 56.87, y: 14.34), controlPoint2: CGPoint(x: 57.37, y: 12.96))
        bezierPath.addCurve(to: CGPoint(x: 57.94, y: 10.55), controlPoint1: CGPoint(x: 57.8, y: 11.28), controlPoint2: CGPoint(x: 57.89, y: 10.89))
        bezierPath.addCurve(to: CGPoint(x: 58, y: 10.12), controlPoint1: CGPoint(x: 57.97, y: 10.35), controlPoint2: CGPoint(x: 57.99, y: 10.2))
        bezierPath.addCurve(to: CGPoint(x: 57.95, y: 9.53), controlPoint1: CGPoint(x: 57.99, y: 9.96), controlPoint2: CGPoint(x: 57.98, y: 9.78))
        bezierPath.addCurve(to: CGPoint(x: 57.79, y: 8.07), controlPoint1: CGPoint(x: 57.91, y: 9.11), controlPoint2: CGPoint(x: 57.86, y: 8.62))
        bezierPath.addCurve(to: CGPoint(x: 56.93, y: 2.89), controlPoint1: CGPoint(x: 57.59, y: 6.51), controlPoint2: CGPoint(x: 57.31, y: 4.76))

        return bezierPath
    }
}


class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // add SKView
        do {
            let skView = SKView(frame:CGRect(x: 0, y: 0, width: 320, height: 480))
            skView.showsFPS = true
            //skView.showsPhysics = true
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

