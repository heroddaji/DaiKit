//
//  DKFloatingControl.swift
//  DressRoom
//
//  Created by daitran on 5/24/15.
//  Copyright (c) 2015 daitran. All rights reserved.
//

import UIKit

class DKFloatingMenu: UIButton {
    
    enum Direction {
        case Left
        case Right
    }
    
    var duration = 0.2
    var delay = 0.0
    var dampingRatio:CGFloat = 0.5
    var velocity:CGFloat = 0.5
    var direction:Direction = .Right
    var spaceBetweenItem:CGFloat = 10
    var isOpen = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        initView()
    }
    
    func initView(){        
        let tapGesture = UITapGestureRecognizer(target: self, action: "respondsToTap:")
        self.addGestureRecognizer(tapGesture)
    }
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        //tip: found this trick on https://developer.apple.com/library/ios/qa/qa2013/qa1812.html
        if isOpen{
            for anyobj in self.subviews {
                if anyobj is DKFloatingMenuItem{
                    let view = anyobj as! DKFloatingMenuItem
                    let pointForSubView = view.convertPoint(point, fromView: self)
                    
                    if CGRectContainsPoint(view.bounds, pointForSubView){
                        return view
                    }
                }
                
            }
        }
        
        return super.hitTest(point, withEvent: event)
        
    }
    
    func addFloatingItem(floatingItem: DKFloatingMenuItem){
        floatingItem.frame = self.bounds
        floatingItem.userInteractionEnabled = true
        floatingItem.alpha = 0
        floatingItem.hidden = true
        self.addSubview(floatingItem)
    }
 
    
    func respondsToTap(sender: UITapGestureRecognizer){        
        if isOpen == true{
            isOpen = false
        }else{
            isOpen = true
            self.superview?.bringSubviewToFront(self)
        }
        
        animateFloatingMenu(isOpen)
        
    }
    
    func animateFloatingMenu(isOpen:Bool){
        
        let openTranslationBlock :  (Direction,CGFloat) -> CGAffineTransform = {
            [weak self] (direction:Direction, index:CGFloat) -> CGAffineTransform in
            
            var delta = (self!.frame.width + self!.spaceBetweenItem) * index
            
            switch direction{
            case .Left:
                return CGAffineTransformMakeTranslation(-delta , 0)
                
            case .Right:
                return CGAffineTransformMakeTranslation(delta , 0)
            }
        }
        
        let closeTranslationBlock :  () -> CGAffineTransform = {
            [weak self] () -> CGAffineTransform in
            return CGAffineTransformMakeTranslation(self!.bounds.width/2 , 0)
        }
        
        
        
        let rotationBlock : (CGFloat) -> CGAffineTransform =  {
            [weak self] (degree:CGFloat) -> CGAffineTransform in
            return CGAffineTransformRotate(CGAffineTransformIdentity, degree)
        }
        
        
        let animation = { [weak self]() -> Void in
            var index:CGFloat = 1
            for anyobj in self!.subviews {
                if isOpen && anyobj is DKFloatingMenuItem{
                    let translationTransform =  openTranslationBlock(self!.direction,index)
                    let view = anyobj as! DKFloatingMenuItem
                    view.hidden = false
                    view.alpha =  1
                    view.transform  = translationTransform
                    index += 1
                    self!.onOpen()
                }else{
                    let translationTransform =  closeTranslationBlock()
                    let view = anyobj as! UIView
                    view.transform = translationTransform
                    view.alpha = 0
                    self!.onClose()
                }
                
            }
            
            //rotate main menu icon 45 degree
            //let rotationTransform = rotationBlock(45)
            //self.imageView?.transform = rotationTransform
            
        }
        
        let completion  = { (bool:Bool) -> Void in
            if !isOpen{
                for anyobj in self.subviews {
                    let view = anyobj as! UIView
                    view.hidden = false
                }
                
            }
        }

        
        UIView.animateWithDuration(duration, delay: delay, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity, options: UIViewAnimationOptions.AllowUserInteraction, animations: animation, completion: completion)
    }
    
    func onOpen(){
        
    }
    
    func onClose(){
        
    }
    
    
}
