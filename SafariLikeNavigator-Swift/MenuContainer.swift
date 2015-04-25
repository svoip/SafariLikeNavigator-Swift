//
//  MenuContainer.swift
//  SafariLikeNavigator-Swift
//
//  Created by Sardorbek on 4/2/15.
//  Copyright (c) 2015 Sardorbek. All rights reserved.
//

import UIKit
import QuartzCore

let TOOLBAR_HEIGHT:CGFloat = 35
let PADDING_BETWEEN_VC: CGFloat = 35

enum MenuState {
   case MenuExpanded  // a single child controller is occupying all screen
   case MenuCollapsed // all child controllers are visible
}

class MenuContainer: UIViewController {
   private var scroll : UIScrollView!
   private var _children: [MenuController] = []
   private var _state:MenuState?
   
   var _expandedChildIndex: Int?
   var _button: UIButton?
   
   init(nibName nibNameOrNil: String?,
      bundle nibBundleOrNil: NSBundle?,
      childControllers children: [MenuController])
   {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      _children = children
      _state = .MenuCollapsed
   }
   
   
   required init(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
   }
   
   func _configureFrames(){
      
      let count = _children.count
      let padding = Int(self._availableScreenHeight())/count
      let height = CGFloat(padding) + PADDING_BETWEEN_VC
      var list : [MenuController] = []
      var frame = CGRectMake(20, 30, 280, height)
      for (index, controller) in enumerate(_children){
         controller.view.frame = frame
         frame.origin.y += CGFloat(padding)
         list.append(controller)
      }
      _children = list
      
   }
   
   func _addChildToScroll(child:MenuController){
      scroll.addSubview(child.view)
   }
   func _addChildrenToScroll(){
      var cv:UIView
      for (index, controller) in enumerate(_children)
      {
         self._addChildToScroll(controller)
      }
   }
   
   func _bend(){
      var cv:UIView
      for (index, controller) in enumerate(_children) {
         cv = controller.view!
         cv.layer.transform = makeSafariLikeTabTransform()
      }
      
   }
   
   func _removeBend(){
      var cv:UIView
      for (index, controller) in enumerate(_children){
         cv = controller.view!
         cv.layer.transform = makeIdentityTabTransform()
      }
   }
   
   
   func _addToolbar(){
      var tb = UIToolbar(frame: CGRectMake(0, self._availableScreenHeight(), 320, TOOLBAR_HEIGHT))
      self.view.addSubview(tb)
      
      _button = UIButton(frame: CGRectMake(0, 0, 80, TOOLBAR_HEIGHT))
      _button!.setTitleColor(UIColor.grayColor(), forState: .Normal)
      _button!.setTitleColor(UIColor.blueColor(), forState: .Highlighted)
      _button!.addTarget(self, action: "toolbarButtonClicked:", forControlEvents: .TouchUpInside)
      var bi = UIBarButtonItem(customView: _button!)
      var spacer = UIBarButtonItem()
      spacer.width = 220
      tb.items = [spacer, bi]
      
   }
   
   func _reframeViewsWithTappedIndex(idx: Int){
      
      let beyond: CGFloat = 500
      for controller in self._children {
         let cidx = find(self._children as [MenuController], controller)
         if cidx == idx {
            // gets the available screen
            let childFrame = CGRectMake(0, 0, 320, self._availableScreenHeight())
            controller.view.frame = childFrame
         }
         // these views hide by going beyond the bottom of the screen
         else if cidx > idx {
            let r = controller.view.frame
            controller.view.frame = CGRectMake(r.origin.x, r.origin.y+beyond, r.size.width, r.size.height)
         }
         // these views hide by going beyond the top of the screen
         else if cidx < idx {
            let r = controller.view.frame
            controller.view.frame = CGRectMake(r.origin.x, r.origin.y-beyond, r.size.width, r.size.height)
         }
      }
      
   }
   
   func _expandToChildControllerAtIndex(idx:Int){
      
      _expandedChildIndex = idx
      let child = _children[idx]
      child.viewWillAppearBlock!(idx: child.index!)
      
      UIView.animateWithDuration(0.5, animations: {
         
         self._removeBend()
         self._reframeViewsWithTappedIndex(idx)
         
         }, completion: nil)
      
      _state = .MenuExpanded
      _button!.setTitle("Menu", forState: .Normal)
      self._toggleViewUserInteraction(true)
   }
   
   
   func _toggleViewUserInteraction(toggleOn: Bool){
      for controller in _children {
         controller.view.userInteractionEnabled = toggleOn
      }
   }
   
   
   func _collapseFromChildControllerAtIndex(idx:Int) {
      let child = _children[idx]
      child.viewWillDisappearBlock!(idx: child.index!)
      
      UIView.animateWithDuration(0.5, animations: {
         self._configureFrames()
         self._bend()
         }, completion:nil)
      
      _state = .MenuCollapsed
      _button!.setTitle("Done", forState: .Normal)
      self._toggleViewUserInteraction(false)
      
   }

   
   func toolbarButtonClicked(sender:UIButton) {
      if _state == .MenuCollapsed {
         self._expandToChildControllerAtIndex(_expandedChildIndex!)
      }
      else if _state == .MenuExpanded {
         self._collapseFromChildControllerAtIndex(_expandedChildIndex!)
      }
   }
   
   
   func _addScroll (){
      // container
      scroll = UIScrollView( frame: CGRectMake(0, 0, 320, self._availableScreenHeight()) )
      scroll.backgroundColor = UIColor.whiteColor()
      scroll.contentSize = CGSizeMake(320, self._screenHeight())
      scroll.showsVerticalScrollIndicator = false
      self.view.addSubview(scroll)
   }
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = UIColor.whiteColor()
      
      self._addScroll()
      self._addToolbar()
      self._configureFrames()
      self._bend()
      self._addChildrenToScroll()
      
      // default behavior, load the 1st child controller's view
      self._expandToChildControllerAtIndex(0)
      
      let gesture = UITapGestureRecognizer(target: self, action: "viewTapped:")
      self.view.addGestureRecognizer(gesture)
      
   }
   
   // MARK: - Touch handlers
   private func _tappedView (p: CGPoint) -> UIView? {
      // since child views will be overlapping each other, we start querying them from the front-most toward the rear-most
      for controller in _children.reverse() {
         if CGRectContainsPoint(controller.view.frame, p) {
            return controller.view
         }
      }
      return nil
   }
   
   
   private func _tappedViewIndex (p: CGPoint) -> Int?{
      var index = -1
      var tv = self._tappedView(p)
      if let tappedView = tv {
         for controller in self._children {
            if controller.view == tappedView {
               index = find(self._children as [MenuController], controller)!
               return index
            }
         }
      }
      return nil
   }
   
   
   func viewTapped(gesture:UITapGestureRecognizer) {
      if gesture.state == .Ended {
         let view = gesture.view!
         let point = gesture.locationInView(view)
         let tvi = self._tappedViewIndex(point)
         if tvi > -1 {
            self._expandToChildControllerAtIndex(tvi!)
         }
      }
      
   }
   
   // MARK: - Utility
   func _screenHeight () -> CGFloat{
      let r = UIScreen.mainScreen().bounds
      return r.size.height
   }
   func _availableScreenHeight () -> CGFloat{
      return self._screenHeight()-TOOLBAR_HEIGHT
   }
   func makeIdentityTabTransform () -> CATransform3D!
   {
      var perspective:CATransform3D
      perspective = CATransform3DIdentity
      return perspective
   }
   func makeSafariLikeTabTransform () -> CATransform3D!
   {
      var perspective:CATransform3D
      perspective = CATransform3DIdentity
      perspective.m34 = -1.0 / 500.0
      perspective = CATransform3DRotate(perspective, -0.4, 1, 0, 0)
      return perspective
   }
}
