import UIKit

extension UIApplication {
    class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

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
    func enterEventTrace(_ funcname:String = #function, filename:String = #file) {
        eventTraceDepth += 1

        let space = String(repeating: " ", count: eventTraceDepth * 4)

        print("\(space)--> \(type(of: self))(\(Unmanaged.passUnretained(self).toOpaque()))::\(funcname)")

        func printView(_ view:UIView) {
            print("\(space)    frame = \(view.frame.rectString())")
            if view.bounds.origin != CGPoint.zero {
                print("\(space)    bounds = \(view.bounds.rectString())")
            }
            if view.window != nil {
                if let superview = view.superview {
                    let rect = superview.convert(view.frame, to: nil)
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
    func exitEventTrace(_ funcname:String = #function, filename:String = #file) {
        eventTraceDepth -= 1
//        print("<-- \(self.dynamicType)(\(unsafeAddressOf(self)))::\(funcname)")
    }
    func logTrace(_ funcname:String = #function) {
        print("\(type(of: self))(\(Unmanaged.passUnretained(self).toOpaque()))::\(funcname) called")
    }
    func logDebug(_ msg:String, funcname:String = #function) {
        print("\(type(of: self))(\(Unmanaged.passUnretained(self).toOpaque()))::\(funcname) \(msg)")
    }
    func logViewHierarchy(_ funcname:String = #function) {
        if let view = UIApplication.topViewController()?.view {
            print("\n>>> View hierarcy at \(funcname)")
            print(view.perform(NSSelectorFromString("recursiveDescription")))
            print("<<< View hierarcy at \(funcname)\n")
        }
        else {
            print("no top view")
        }
    }
}
