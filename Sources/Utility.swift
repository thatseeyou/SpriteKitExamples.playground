import Foundation

open class Utility
{

/** run closure after given seconds

- parameter second: delayed time (seconds)
- parameter action: action to run
*/
    open class func runActionAfterTime(_ second:Double, action:@escaping () -> Void) {
        let delayTime = DispatchTime.now() + second
        
        DispatchQueue.main.asyncAfter(deadline: delayTime, execute: action)
    }

}

