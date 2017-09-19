/*:
Prepare for key window and live view
*/
import Foundation
import UIKit
//import XCPlayground
import PlaygroundSupport

open class PlaygroundHelper
{

/** mimic iOS initialization
- parameter width: width of window (default 320)
- parameter height: height of window (default 480)
*/
    open class func initWindow(_ width:CGFloat = 320.0, _ height:CGFloat = 480.0)
    {
        /*:
        다음과 같이 하면 에러 메시지가 표시된다.
        - window.rootViewController = ViewController()

        에러 메시지
        - Presenting view controllers on detached view controllers is discouraged

        다음과 같이 수정
        - UIApplication.sharedApplication().keyWindow!.rootViewController = ViewController()
        */
        let window : UIWindow! = UIWindow(frame: CGRect(x: 0.0, y: 0.0, width: width, height: height))
        window.backgroundColor = UIColor.gray
        window.makeKeyAndVisible()
//        XCPlaygroundPage.currentPage.liveView = UIApplication.shared.keyWindow!
        PlaygroundPage.current.liveView = UIApplication.shared.keyWindow!
        print(UIApplication.shared.keyWindow!)
    }

/** make UIWindow and show viewController.view
 - parameter viewController: root view controller
 - parameter width: width of window (default 320)
 - parameter height: height of window (default 480)
 */
    open class func showViewController(_ viewController:UIViewController, width:CGFloat = 320.0, height:CGFloat = 480.0)
    {
        self.initWindow(width, height)
        UIApplication.shared.keyWindow!.rootViewController = viewController
    }

}
