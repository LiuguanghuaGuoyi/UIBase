//
//  WrapNavigationController.swift
//  xinkeqiSwift
//
//  Created by 新科奇 on 2017/11/16.
//  Copyright © 2017年 新科奇. All rights reserved.
//

import UIKit


/// 重写导航控制器的方法,让所有的操作都使用真正执行者来执行
class WrapNavigationController: UINavigationController {

    override func popViewController(animated: Bool) -> UIViewController? {
        return self.navigationController?.popViewController(animated:animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        return self.navigationController?.popToRootViewController(animated:animated)
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        debugPrint(viewController)
        // 拿到真正执行导航功能的控制器
//        debugPrint(viewController.gh_navigation_controller)
        let gh_navigation_controller = viewController.gh_navigation_controller!
        // 获取要出栈的控制器,在真正控制器栈里面的index
        let index = gh_navigation_controller.ghViewControllers.firstIndex(of: viewController) ?? 0
        // 出栈包装的控制器
        return self.navigationController?.popToViewController(gh_navigation_controller.viewControllers[index], animated: animated)
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 绑定真正执行导航功能的导航控制器
        viewController.gh_navigation_controller = self.navigationController as? NavigationController
        // 设置返回图片
        let image = viewController.gh_navigation_controller?.backButtonImage ?? UIImage(named: "back_b")
        
        // 设置返回按钮
//        let backBtn = UIButton(type: .custom)
//        backBtn.setTitleColor(UIColor.white, for: .normal)
////        backBtn.setTitle("返回", for: .normal)
//        backBtn.setImage(image, for: .normal)
////        backBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
////        backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0)
//        backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -4, 0, 0)
//        let rect = backBtn.sizeThatFits(CGSize(width: 100, height: 100))
//        backBtn.bounds = CGRect(x: 0, y: 0, width: rect.width + 20, height: 44)
//        backBtn.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
//        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(didTapBackButton))
        // 入栈
        self.navigationController?.pushViewController(WrapViewController.init(viewController: viewController), animated: animated)
        
    }
    
    /// 出栈action
    @objc func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
