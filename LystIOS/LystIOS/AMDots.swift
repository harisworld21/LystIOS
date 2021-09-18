

import UIKit

public extension UIImageView {
    
    func spin()
    {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {() -> Void in
            self.transform = self.transform.rotated(by: .pi / 2)
        }, completion: {(_ finished: Bool) -> Void in
            if finished {
                self.spin()
            }
        })
    }
    
//    func spin() {
//        let rotation = CABasicAnimation(keyPath: "transform.rotation")
//        rotation.fromValue = 0
//        rotation.toValue = 2 * Double.pi
//        rotation.duration = 1.0
////        rotation.repeatCount = duration
//        layer.add(rotation, forKey: "rotationAnimation")
//        self.isHidden = false
//
//
//    }
//
    func stopSpinning() {
        layer.removeAllAnimations()
        self.isHidden = true
    }
}
