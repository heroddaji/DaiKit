//
//  FloatingMenuViewController.swift
//  DaiUIKit
//
//  Created by daitran on 5/26/15.
//  Copyright (c) 2015 daitran. All rights reserved.
//

import UIKit

class FloatingMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var floatingMenu = DKFloatingMenu(frame: CGRectMake(20, 100, 50, 50))
        floatingMenu.backgroundColor = UIColor.yellowColor()
        floatingMenu.dampingRatio = 0.35
        floatingMenu.duration = 0.6
        view.addSubview(floatingMenu)
        
        var floatingMenuItem1 = DKFloatingMenuItem()
        floatingMenuItem1.identifier = "apple"
        floatingMenuItem1.addTarget(self, action: "event1:", forControlEvents: UIControlEvents.TouchUpInside)
        floatingMenuItem1.setImage(UIImage(named: "apple"), forState: UIControlState.Normal)
        
        var floatingMenuItem2 = DKFloatingMenuItem()
        floatingMenuItem2.addTarget(self, action: "event2", forControlEvents: UIControlEvents.TouchUpInside)
        floatingMenuItem2.setImage(UIImage(named: "cart"), forState: UIControlState.Normal)
        
        floatingMenu.addFloatingItem(floatingMenuItem1)
        floatingMenu.addFloatingItem(floatingMenuItem2)
        
        
    }
    
    func event1(sender: DKFloatingMenuItem){
        NSLog("event 1: sender has identifier:\(sender.identifier)")
    }

    
    func event2(){
        NSLog("event 2")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
