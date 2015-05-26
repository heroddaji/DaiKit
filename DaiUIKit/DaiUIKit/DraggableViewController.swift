//
//  DraggableViewController.swift
//  DaiUIKit
//
//  Created by daitran on 5/26/15.
//  Copyright (c) 2015 daitran. All rights reserved.
//

import UIKit

class DraggableViewController: UIViewController, DKDraggableViewDelegate {

    @IBOutlet weak var apple:DKDraggableView!
    @IBOutlet weak var cart1: UIImageView!
    @IBOutlet weak var cart2: UIImageView!
    @IBOutlet weak var cart3: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apple.delegate = self
        apple.enableDragging = true
        apple.setDropTarget(cart1)
       

    }
    
    func onDropedToTarget(sender: DKDraggableView, target:UIView) {
        NSLog("Drop to target \(target.tag)")
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
