//
//  Bubble.swift
//  bpgame
//
//  Created by Zhangwei Chen on 9/5/20.
//  Copyright © 2020 Zhangwei Chen. All rights reserved.
//

import UIKit
class Bubble: UIButton {
    var value:Double = 0
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    override init(frame: CGRect) {
        super.init(frame:frame)
        let possibility = Int.random(in:0...99)
        switch possibility {
        case 0...39:
//            self.backgroundColor = UIColor.red
            self.backgroundColor = UIColor.init(displayP3Red: 0.949, green: 0.0275, blue: 0.0275,alpha: 1)
            self.value = 1
        case 40...69:
//            self.backgroundColor = UIColor.systemPink
            self.backgroundColor = UIColor.init(displayP3Red: 0.9373, green: 0.3647, blue: 0.651, alpha: 1)
            self.value = 2
        case 70...84:
//            self.backgroundColor = UIColor.green
            self.backgroundColor = UIColor.init(displayP3Red: 0.1216, green: 0.7686, blue: 0.0196, alpha: 1)
            self.value = 5
        case 85...94:
//            self.backgroundColor = UIColor.blue
            self.backgroundColor = UIColor.init(displayP3Red: 0, green: 0.5294, blue: 1, alpha: 1)
            self.value = 8
        case 95...99:
//            self.backgroundColor = UIColor.black
            self.backgroundColor = UIColor.init(displayP3Red: 0.0471, green: 0.0157, blue: 0, alpha: 1)
            self.value = 10
        default: print("error")
        }
        
        
        }
    func pulsate(){
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.8
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse,forKey: "pulse")
    }
    
}
