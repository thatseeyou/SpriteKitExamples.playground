import Foundation

public class Utility
{

/** run closure after given seconds

- parameter second: delayed time (seconds)
- parameter action: action to run
*/
    public class func runActionAfterTime(second:Float, action:() -> Void) {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(second) * Double(NSEC_PER_SEC)))
        
        dispatch_after(delayTime, dispatch_get_main_queue(), action)
    }

}

