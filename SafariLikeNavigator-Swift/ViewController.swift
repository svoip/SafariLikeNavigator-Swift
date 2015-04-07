//
//  ViewController.swift
//  SafariLikeNavigator-Swift
//
//  Created by Sardorbek on 4/2/15.
//  Copyright (c) 2015 Sardorbek. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {

   //var animation : MenuAnimation?
   
   // from "storyboard-ctrl-drag"
   @IBOutlet weak var myButton: UIButton!
   
   @IBAction func myButtonClicked(sender: AnyObject) {
      //println("my button: \(myButton)")
      /*
      var menu = MenuController(nibName: nil, bundle: nil, children: nil)
      menu.transitioningDelegate = self
      self.presentViewController(menu, animated: true, completion: nil)
      */
   }
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      /*
      myButton.layer.borderColor = UIColor.grayColor().CGColor
      myButton.layer.borderWidth = 1.0

      view.layer.borderColor = UIColor.greenColor().CGColor
      view.layer.borderWidth = 1.0
      
      //println("my button constraints: \(myButton.constraints())")
      //println("amb: \(myButton.hasAmbiguousLayout())")
      
      animation = MenuAnimation()
      */
   }


   /*
   func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      return animation
   }
   
   func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      return animation
   }
   */
}


/*

// UIViewControllerTransitioningDelegate


optional func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?

optional func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?

optional func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?

optional func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?

@availability(iOS, introduced=8.0)
optional func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController!, sourceViewController source: UIViewController) -> UIPresentationController?
*/
