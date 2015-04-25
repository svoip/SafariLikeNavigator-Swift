//
//  MenuController.swift
//  SafariLikeNavigator-Swift
//
//  Created by Sardorbek on 4/5/15.
//  Copyright (c) 2015 Sardorbek. All rights reserved.
//

import UIKit

typealias ViewWillAppearCompletionBlock = (idx: Int) -> Void
typealias ViewWillDisappearCompletionBlock = (idx: Int) -> Void

class MenuController: UIViewController {
   var viewWillAppearBlock: ViewWillAppearCompletionBlock?
   var viewWillDisappearBlock: ViewWillDisappearCompletionBlock?
   var index: Int?
}
