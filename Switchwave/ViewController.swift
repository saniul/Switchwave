//
//  ViewController.swift
//  Switchwave
//
//  Created by Saniul Ahmed on 20/12/2014.
//  Copyright (c) 2014 Saniul Ahmed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let xResolution = 13;
    let yResolution = 13;
    let size: CGFloat = 52;
    
    let containerView = UIView()
    var switches = [UISwitch]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.containerView)
        self.containerView.frame.size = CGSizeMake(CGFloat(xResolution)*size, CGFloat(yResolution)*size)
        self.containerView.center = CGPointMake(self.view.bounds.midX, self.view.bounds.midY)
        self.containerView.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleBottomMargin
        
        for i in 0..<xResolution {
            for j in 0..<yResolution {
                let switchView = UISwitch()
                self.containerView.addSubview(switchView)
                let frame = CGRect(x: CGFloat(i)*size, y: CGFloat(j)*size, width: size, height: size)
                switchView.frame = frame
                switchView.addTarget(self, action: Selector("valueChanged:"), forControlEvents: .ValueChanged)
                self.switches += [switchView]
            }
        }
    }
    
    func valueChanged(targetSwitch: UISwitch) {
        let on = targetSwitch.on
        
        for aSwitch in self.switches {
            let dx = targetSwitch.frame.minX - aSwitch.frame.minX
            let dy = targetSwitch.frame.minY - aSwitch.frame.minY
            let distance = sqrt( dx * dx + dy * dy)
            let delay = NSTimeInterval(round(distance * 1.8))/1000
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * NSTimeInterval(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                aSwitch.setOn(on, animated: true)
            }
            
            //not *quite* the same as checkwave, but who cares?
            UIView.animateKeyframesWithDuration(0.5, delay: delay, options: UIViewKeyframeAnimationOptions.CalculationModeCubic | UIViewKeyframeAnimationOptions.AllowUserInteraction | UIViewKeyframeAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
                UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.3, animations: { () -> Void in
                    aSwitch.transform = CGAffineTransformMakeScale(1.5, 1.5)
                })
                UIView.addKeyframeWithRelativeStartTime(0.3, relativeDuration: 0.7, animations: { () -> Void in
                    aSwitch.transform = CGAffineTransformMakeScale(1, 1)
                })
            }, completion: nil)
        }
    }


}

