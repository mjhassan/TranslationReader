//
//  RootWireframe.swift
//  DoubleScroller
//
//  Created by Jahid Hassan on 2/6/17.
//  Copyright © 2017 Jahid Hassan. All rights reserved.

import Foundation
import UIKit

class RootWireframe : NSObject {
    func showRootViewController(_ viewController: UIViewController, inWindow: UIWindow) {
        let navigationController = navigationControllerFromWindow(inWindow)
        navigationController.viewControllers = [viewController]
    }
    
    func navigationControllerFromWindow(_ window: UIWindow) -> UINavigationController {
        let navigationController = window.rootViewController as! UINavigationController
        return navigationController
    }
}
