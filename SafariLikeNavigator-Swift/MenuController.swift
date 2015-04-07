//
//  MenuController.swift
//  SafariLikeNavigator-Swift
//
//  Created by Sardorbek on 4/2/15.
//  Copyright (c) 2015 Sardorbek. All rights reserved.
//

import UIKit
import QuartzCore

enum MenuState {
   case MenuExpanded  // a single child controller is visible
   case MenuCollapsed // all child controllers are visible
}

class MenuController: UIViewController {
   var scroll : UIScrollView!

   var _children: [MenuChildController] = []

   var _state:MenuState?
   
   var _expandedChildIndex: Int?
   var _button: UIButton?
   
   init(nibName nibNameOrNil: String?,
      bundle nibBundleOrNil: NSBundle?,
      childControllers children: [MenuChildController])
   {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      _children = children

      _state = .MenuCollapsed
   }


   required init(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)

   }

   func _configureFrames(){
      var height:CGFloat = 150.0
      var padding:CGFloat = 100.0
 
      let n = _children.count
      
      if n<4
      {
         height = 200.0
         padding = 150.0
      }
      
      var list : [MenuChildController] = []
      var frame = CGRectMake(20, 40, 280, height)
     
   
      let nd:Double = Double(n)
      let bounds:CGRect = UIScreen.mainScreen().bounds
      let h:Double = Double(bounds.size.height)
      let result = h/nd
      // gap = CGFloat(result)
      
      println("media: \(n), \(result)")
      
      for (index, controller) in enumerate(_children)
      {
         controller.view.frame = frame
         frame.origin.y += padding
         list.append(controller)
      }
      _children = list
      
   }
   
   func _addChildren(){
      
      var cv:UIView
      for (index, controller) in enumerate(_children)
      {
         cv = controller.view!
         scroll.addSubview(cv)
      }
   }
   
   func _bend(){
      var cv:UIView
      for (index, controller) in enumerate(_children)
      {
         cv = controller.view!
         cv.layer.transform = makeSafariLikeTabTransform()
      }

   }
   
   func _removeBend(){
      var cv:UIView
      for (index, controller) in enumerate(_children)
      {
         cv = controller.view!
         cv.layer.transform = makeIdentityTabTransform()
      }
   }
   

   func _addToolbar(){
      var tb = UIToolbar(frame: CGRectMake(0, 568-35, 320, 35))
      tb.layer.borderWidth = 1
      tb.layer.borderColor = UIColor.lightGrayColor().CGColor
      self.view.addSubview(tb)
      
      _button = UIButton(frame: CGRectMake(0, 0, 80, 35))
      _button!.setTitle("-> Child", forState: .Normal)
      _button!.setTitleColor(UIColor.grayColor(), forState: .Normal)
      _button!.setTitleColor(UIColor.blueColor(), forState: .Highlighted)
      _button!.addTarget(self, action: "toolbarButtonClicked:", forControlEvents: .TouchUpInside)
      
      //_button!.layer.borderColor = UIColor.redColor().CGColor
      //_button!.layer.borderWidth = 1
      
      var bi = UIBarButtonItem(customView: _button!)
      var spacer = UIBarButtonItem()
      spacer.width = 210
      tb.items = [spacer, bi]
      
   }
   
   func __printFrame(){
      for controller in self._children
      {
         println("the_frame: \(controller.view.frame)")
      }
   }
   
   func __reframeViewsWithTappedIndex(idx: Int){
      
      let gap: CGFloat = 500
      for controller in self._children
      {
         let cidx = find(self._children as [MenuChildController], controller)
         // println("this index: \(cidx), passed inde: \(idx)")
         
         if cidx == idx
         {
            // leave alone
            let childFrame = CGRectMake(0, 0, 320, 568-35)
            controller.view.frame = childFrame
         }
         // these views hide by going under
         else if cidx > idx
         {
            let r = controller.view.frame
            controller.view.frame = CGRectMake(r.origin.x, r.origin.y+gap, r.size.width, r.size.height)
         }
         // these views hide by going top
         else if cidx < idx
         {
            let r = controller.view.frame
            controller.view.frame = CGRectMake(r.origin.x, r.origin.y-gap, r.size.width, r.size.height)
         }
      }

   }
   
   func __reframeViewsWithTappedIndex2(idx: Int){
      
      self._configureFrames()
  
   }

   
   func __expandToChildControllerAtIndex(idx:Int){
      
      _expandedChildIndex = idx
      
      //println("BEFORE")
      //self.__printFrame()
   
      let child = _children[idx]
      //let childView = child.view
      child.viewWillAppearBlock!()
      //let childFrame = CGRectMake(0, 0, 320, 568-35)
   
      UIView.animateWithDuration(0.4, animations: {
     
         self._removeBend()
      
         self.__reframeViewsWithTappedIndex(idx)
         
         }, completion: {
            _ in
 
            //println("AFTER")
            //self.__printFrame()
      })
      
      _state = .MenuExpanded
      
      _button!.setTitle("Menu", forState: .Normal)
      
      self.__toggleViewUserInteraction(true)
   }

   
   func __toggleViewUserInteraction(toggleOn: Bool){

      for controller in _children
      {
         controller.view.userInteractionEnabled = toggleOn
      }
   }
   
   
   func __collapseFromChildControllerAtIndex(idx:Int){
      
      let child = _children[idx]
      child.viewWillDisappearBlock!()
      
      UIView.animateWithDuration(0.5, animations: {
  
         self.__reframeViewsWithTappedIndex2(idx)
   
         self._bend()
 
         }, completion: {
            _ in
            
      })
      
      _state = .MenuCollapsed
      
      _button!.setTitle("Done", forState: .Normal)
      
      self.__toggleViewUserInteraction(false)

   }
   
   
   func toolbarButtonClicked(sender:UIButton)
   {
  
      if _state == .MenuCollapsed
      {
         println("Parent -> Child")
         self.__expandToChildControllerAtIndex(_expandedChildIndex!)

      }
      else if _state == .MenuExpanded
      {
         println("Child -> Parent")
         self.__collapseFromChildControllerAtIndex(_expandedChildIndex!)
     
      }
      
   }
   
   func _addScroll (){
      // container
      // scroll = UIScrollView(frame: self.view.bounds)
      scroll = UIScrollView(frame: CGRectMake(0, 0, 320, 568-35))
      scroll.backgroundColor = UIColor.whiteColor()
      scroll.contentSize = CGSizeMake(320, 568)
      scroll.showsVerticalScrollIndicator = false
      scroll.layer.borderWidth = 4
      scroll.layer.borderColor = UIColor.grayColor().CGColor
      self.view.addSubview(scroll)
      println("content_size: \(scroll.contentSize)")
   }
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = UIColor.whiteColor()
   
      self._addScroll()
      self._addToolbar()
      
      self._configureFrames()
      self._bend()
      
      self._addChildren()

      // default behavior, load the 1st child controller's view
      self.__expandToChildControllerAtIndex(0)
      
      let gesture = UITapGestureRecognizer(target: self, action: "viewTapped:")
      self.view.addGestureRecognizer(gesture)
      
   }
   
   func _tappedView (p: CGPoint) -> UIView?
   {
      // since childs views overlap each other, we start querying them from the front-most toward the rear-most
      for controller in _children.reverse()
      {
         if CGRectContainsPoint(controller.view.frame, p)
         {
            return controller.view
         }
      }
      return nil
   }
   
   func _tappedViewIndex (p: CGPoint) -> Int?{
      var index = -1
      var tv = self._tappedView(p)?
      if let tappedView = tv{
         for controller in self._children
         {
            if controller.view == tappedView{
               index = find(self._children as [MenuChildController], controller)!
            }
         }
      }
      
      return index
   }
   
   
   func viewTapped(gesture:UITapGestureRecognizer)
   {
      if gesture.state == .Ended
      {
         let view = gesture.view!
         let point = gesture.locationInView(view)
         let tvi = self._tappedViewIndex(point)
   
         if tvi > -1
         {
            self.__expandToChildControllerAtIndex(tvi!)
         }
      }

   }
 
   // Utility
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
