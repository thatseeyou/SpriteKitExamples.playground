import UIKit

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.sharedApplication().keyWindow?.rootViewController) -> UIViewController? {

        return base
    }
}

extension CGRect {
    func rectString() -> String {
        // frame = (0 0; 320 480)
        return "(\(Int(self.origin.x)) \(Int(self.origin.y)); \(Int(self.size.width)) \(Int(self.size.height)))"
    }
}

var eventTraceDepth = -1

public extension NSObject {
    func enterEventTrace(funcname:String = #function, filename:String = #file) {
        eventTraceDepth += 1

        let space = String(count: eventTraceDepth * 4, repeatedValue: Character(" "))

        print("\(space)--> \(self.dynamicType)(\(unsafeAddressOf(self)))::\(funcname)")

        func printView(view:UIView) {
            print("\(space)    frame = \(view.frame.rectString())")
            if view.bounds.origin != CGPointZero {
                print("\(space)    bounds = \(view.bounds.rectString())")
            }
            if view.window != nil {
                if let superview = view.superview {
                    let rect = superview.convertRect(view.frame, toView: nil)
                    print("\(space)    screen = \(rect.rectString())")
                }
            }
        }

        if let view = self as? UIView {
            printView(view)
        }

        if let viewController = self as? UIViewController {
            if let view = viewController.view {
                printView(view)
            }
        }
    }
    func exitEventTrace(funcname:String = #function, filename:String = #file) {
        eventTraceDepth -= 1
//        print("<-- \(self.dynamicType)(\(unsafeAddressOf(self)))::\(funcname)")
    }
    func logTrace(funcname:String = #function) {
        print("\(self.dynamicType)(\(unsafeAddressOf(self)))::\(funcname) called")
    }
    func logDebug(msg:String, funcname:String = #function) {
        print("\(self.dynamicType)(\(unsafeAddressOf(self)))::\(funcname) \(msg)")
    }
    func logViewHierarchy(funcname:String = #function) {
        if let view = UIApplication.topViewController()?.view {
            print("\n>>> View hierarcy at \(funcname)")
            print(view.performSelector(Selector("recursiveDescription")))
            print("<<< View hierarcy at \(funcname)\n")
        }
        else {
            print("no top view")
        }
    }
}
