/*:
Prepare for key window and live view
*/
import Foundation
import UIKit
import XCPlayground

public class PlaygroundHelper
{

/** mimic iOS initialization
- parameter width: width of window (default 320)
- parameter height: height of window (default 480)
*/
    public class func initWindow(width:CGFloat = 320.0, _ height:CGFloat = 480.0)
    {
        /*:
        다음과 같이 하면 에러 메시지가 표시된다.
        - window.rootViewController = ViewController()

        에러 메시지
        - Presenting view controllers on detached view controllers is discouraged

        다음과 같이 수정
        - UIApplication.sharedApplication().keyWindow!.rootViewController = ViewController()
        */
        let window : UIWindow! = UIWindow(frame: CGRectMake(0.0, 0.0, width, height))
        window.backgroundColor = UIColor.grayColor()
        window.makeKeyAndVisible()
        XCPlaygroundPage.currentPage.liveView = UIApplication.sharedApplication().keyWindow!
        print(UIApplication.sharedApplication().keyWindow!)
    }

/** make UIWindow and show viewController.view
 - parameter viewController: root view controller
 - parameter width: width of window (default 320)
 - parameter height: height of window (default 480)
 */
    public class func showViewController(viewController:UIViewController, width:CGFloat = 320.0, height:CGFloat = 480.0)
    {
        self.initWindow(width, height)
        UIApplication.sharedApplication().keyWindow!.rootViewController = viewController
    }

}