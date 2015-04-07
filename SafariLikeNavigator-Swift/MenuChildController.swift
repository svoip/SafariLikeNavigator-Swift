//
//  MenuChildController.swift
//  SafariLikeNavigator-Swift
//
//  Created by Sardorbek on 4/5/15.
//  Copyright (c) 2015 Sardorbek. All rights reserved.
//

import UIKit

typealias ViewWillAppearCompletionBlock = () -> Void
typealias ViewWillDisappearCompletionBlock = () -> Void

class MenuChildController: UIViewController {

   var viewWillAppearBlock: ViewWillAppearCompletionBlock?
   var viewWillDisappearBlock: ViewWillDisappearCompletionBlock?
   
    override func viewDidLoad() {
      super.viewDidLoad()
      
      println("child--vDl")
/*
      var button : UIButton = UIButton(frame: CGRectMake(0, 20, 100, 35))
  
      button.setTitle("Menu", forState: .Normal)
      button.setTitleColor(UIColor.grayColor(), forState: .Normal)
      
      button.addTarget(self, action: "showMenu:", forControlEvents: .TouchUpInside)
      self.view.addSubview(button)
      
      button.layer.borderColor = UIColor.blackColor().CGColor
      button.layer.borderWidth = 1
      
      // println("button_: \(button.titleLabel?)")
*/
      
      
      var label : UILabel = UILabel(frame: CGRectMake(0, 40, 280, 200))
      label.text = "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum"
      //label.text = "foo"
      label.numberOfLines = 0
      label.font = UIFont(name: "Helvetica", size: 20)
      label.layer.borderColor = UIColor.blackColor().CGColor
      label.layer.borderWidth = 1
      // self.view.addSubview(label)
      
      
    }


   override func viewWillAppear(animated: Bool) {
      super.viewWillAppear(animated)
      println("child--vWa")

      //
   }
   override func viewDidAppear(animated: Bool) {
      super.viewDidAppear(animated)

   }
   
}
