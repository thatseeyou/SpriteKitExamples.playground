/*:
 ### UIBezierPath를 이용해서 SKShapeNode를 만들 수 있다.
 */
import UIKit
import SpriteKit

class GameScene: SKScene {
    var contentCreated = false

    override func didMoveToView(view: SKView) {
        if self.contentCreated != true {

            let shape = SKShapeNode(path: makeBezierPath().CGPath)
            shape.strokeColor = SKColor.greenColor()
            shape.fillColor = SKColor.redColor()
            shape.position = CGPointMake(self.frame.midX, self.frame.midY)

            addChild(shape)

            self.contentCreated = true
        }
    }

    func makeBezierPath() -> UIBezierPath {
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(26.5, 3.5))
        bezierPath.addCurveToPoint(CGPointMake(45.5, 21.5), controlPoint1: CGPointMake(18.21, -1.33), controlPoint2: CGPointMake(58.09, 18.38))
        bezierPath.addCurveToPoint(CGPointMake(-18.5, 39.5), controlPoint1: CGPointMake(39.21, 23.06), controlPoint2: CGPointMake(-14.26, 38.35))
        bezierPath.addCurveToPoint(CGPointMake(-18.5, 21.5), controlPoint1: CGPointMake(-37.39, 44.62), controlPoint2: CGPointMake(5.5, 27.5))
        bezierPath.addLineToPoint(CGPointMake(-50.05, 10.11))
        bezierPath.addCurveToPoint(CGPointMake(-27.34, -25.5), controlPoint1: CGPointMake(-48.7, -15.86), controlPoint2: CGPointMake(-45.79, -20.5))
        bezierPath.addCurveToPoint(CGPointMake(5.02, -33.21), controlPoint1: CGPointMake(-23.12, -26.64), controlPoint2: CGPointMake(-1.28, -31.65))
        bezierPath.addCurveToPoint(CGPointMake(50.98, -12.45), controlPoint1: CGPointMake(27.89, -38.88), controlPoint2: CGPointMake(42.61, -30.3))
        bezierPath.addCurveToPoint(CGPointMake(56, 3.07), controlPoint1: CGPointMake(53.3, -7.52), controlPoint2: CGPointMake(54.93, -2.22))
        bezierPath.addCurveToPoint(CGPointMake(56.85, 8.19), controlPoint1: CGPointMake(56.38, 4.92), controlPoint2: CGPointMake(56.66, 6.64))
        bezierPath.addCurveToPoint(CGPointMake(57.01, 9.62), controlPoint1: CGPointMake(56.92, 8.73), controlPoint2: CGPointMake(56.97, 9.2))
        bezierPath.addCurveToPoint(CGPointMake(57.05, 10.11), controlPoint1: CGPointMake(57.03, 9.86), controlPoint2: CGPointMake(57.05, 10.03))
        bezierPath.addCurveToPoint(CGPointMake(57, 10.41), controlPoint1: CGPointMake(57.05, 10.1), controlPoint2: CGPointMake(57.03, 10.22))
        bezierPath.addCurveToPoint(CGPointMake(56.77, 11.49), controlPoint1: CGPointMake(56.95, 10.72), controlPoint2: CGPointMake(56.88, 11.08))
        bezierPath.addCurveToPoint(CGPointMake(55.28, 15.41), controlPoint1: CGPointMake(56.47, 12.67), controlPoint2: CGPointMake(55.99, 13.99))
        bezierPath.addCurveToPoint(CGPointMake(-35.5, -17.5), controlPoint1: CGPointMake(53.26, 19.49), controlPoint2: CGPointMake(-30.41, -21.33))
        bezierPath.addCurveToPoint(CGPointMake(4.83, 42.2), controlPoint1: CGPointMake(-44.38, -10.82), controlPoint2: CGPointMake(22.82, 39.23))
        bezierPath.addCurveToPoint(CGPointMake(26.5, -17.5), controlPoint1: CGPointMake(-13.55, 45.23), controlPoint2: CGPointMake(35.15, -12.72))
        bezierPath.addCurveToPoint(CGPointMake(-48.22, 21.17), controlPoint1: CGPointMake(19.52, -21.36), controlPoint2: CGPointMake(-46.12, 29.43))
        bezierPath.addCurveToPoint(CGPointMake(-50.06, 10.03), controlPoint1: CGPointMake(-49.02, 18), controlPoint2: CGPointMake(-49.4, 15.52))
        bezierPath.addLineToPoint(CGPointMake(-51, 10.14))
        bezierPath.addCurveToPoint(CGPointMake(-49.14, 21.39), controlPoint1: CGPointMake(-50.33, 15.67), controlPoint2: CGPointMake(-49.95, 18.17))
        bezierPath.addCurveToPoint(CGPointMake(-35.67, 40.07), controlPoint1: CGPointMake(-46.99, 29.88), controlPoint2: CGPointMake(-42.91, 36.07))
        bezierPath.addCurveToPoint(CGPointMake(4.98, 43.12), controlPoint1: CGPointMake(-26.81, 44.97), controlPoint2: CGPointMake(-13.58, 46.18))
        bezierPath.addCurveToPoint(CGPointMake(45.35, 28.15), controlPoint1: CGPointMake(23.12, 40.12), controlPoint2: CGPointMake(36.34, 34.93))
        bezierPath.addCurveToPoint(CGPointMake(56.13, 15.82), controlPoint1: CGPointMake(50.56, 24.23), controlPoint2: CGPointMake(54.04, 20.03))
        bezierPath.addCurveToPoint(CGPointMake(57.69, 11.72), controlPoint1: CGPointMake(56.87, 14.34), controlPoint2: CGPointMake(57.37, 12.96))
        bezierPath.addCurveToPoint(CGPointMake(57.94, 10.55), controlPoint1: CGPointMake(57.8, 11.28), controlPoint2: CGPointMake(57.89, 10.89))
        bezierPath.addCurveToPoint(CGPointMake(58, 10.12), controlPoint1: CGPointMake(57.97, 10.35), controlPoint2: CGPointMake(57.99, 10.2))
        bezierPath.addCurveToPoint(CGPointMake(57.95, 9.53), controlPoint1: CGPointMake(57.99, 9.96), controlPoint2: CGPointMake(57.98, 9.78))
        bezierPath.addCurveToPoint(CGPointMake(57.79, 8.07), controlPoint1: CGPointMake(57.91, 9.11), controlPoint2: CGPointMake(57.86, 8.62))
        bezierPath.addCurveToPoint(CGPointMake(56.93, 2.89), controlPoint1: CGPointMake(57.59, 6.51), controlPoint2: CGPointMake(57.31, 4.76))

        return bezierPath
    }
}


class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // add SKView
        do {
            let skView = SKView(frame:CGRectMake(0, 0, 320, 480))
            skView.showsFPS = true
            //skView.showsPhysics = true
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

