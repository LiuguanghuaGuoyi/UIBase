//
//  UIViewController (Navigation).swift
//  xinkeqiSwift
//
//  Created by 新科奇 on 2017/11/16.
//  Copyright © 2017年 新科奇. All rights reserved.
//

import UIKit


var gh_navigation_controller_key = "gh_navigation_controller"
extension UIViewController {
    
    
    
    var gh_navigation_controller: NavigationController? {
        get {
            return objc_getAssociatedObject(self, &gh_navigation_controller_key) as? NavigationController
        }
        set(newValue) {
            objc_setAssociatedObject(self, &gh_navigation_controller_key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
//    func gh_navigation_controller() -> NavigationController? {
//        return objc_getAssociatedObject(self, "gh_navigation_controller") as? NavigationController
//    }
//
//    func setGh_navigation_controller(naviCtl: NavigationController?) {
//        objc_setAssociatedObject(self, "gh_navigation_controller", naviCtl, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
//    }
    
}
