//
//  WrapViewController.swift
//  xinkeqiSwift
//
//  Created by 新科奇 on 2017/11/16.
//  Copyright © 2017年 新科奇. All rights reserved.
//

import UIKit

class WrapViewController: UIViewController {
    
    
    /// 根控制器, 就是真实展示界面的控制器
    var rootViewController: UIViewController? {
        get {
            let wrapNaviCtl = self.children.first as? WrapNavigationController
            return wrapNaviCtl?.viewControllers.first
            
        }
    }
    
    
    /// 可以自定义导航栏的导航控制器
    let wrapNaviVc: WrapNavigationController = WrapNavigationController()
    
    
    init(viewController: UIViewController) {
        
        super.init(nibName: nil, bundle: nil)
        // 包装一个导航控制器,方便自定义自己的导航栏
        wrapNaviVc.viewControllers = [viewController]
        // 添加子控制器
        addChild(wrapNaviVc)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 将包装后的控制器添加进视图
        view.addSubview(wrapNaviVc.view)
        
    }
        
    
    /// 基础界面相关属性
    override var hidesBottomBarWhenPushed: Bool {
        get {
            return rootViewController?.hidesBottomBarWhenPushed ?? false
        }
        set {
            rootViewController?.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
        }
    }
    
    override var tabBarItem: UITabBarItem! {
        get {
            return rootViewController?.tabBarItem ?? UITabBarItem()
        }
        set {
            rootViewController?.tabBarItem = tabBarItem
        }
    }
    
    override var title: String? {
        get {
            return rootViewController?.title
        }
        set {
            rootViewController?.title = title
        }
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return rootViewController
    }
    
    override var childForStatusBarHidden: UIViewController? {
        return rootViewController
    }
    
    
}
