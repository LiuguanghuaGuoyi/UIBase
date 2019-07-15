//
//  NavigationController.swift
//  xinkeqiSwift
//
//  Created by 新科奇 on 2017/11/16.
//  Copyright © 2017年 新科奇. All rights reserved.
//

import UIKit

/// 是否接受侧滑返回
@objc protocol NavigationControllerShouldPopProtocol {
    @objc optional
    func navigationControllerShouldStartInteractivePopGestureRecognizer(navigationController: UINavigationController) -> Bool
}

class NavigationController: UINavigationController {

    /// 返回按钮图片
    var backButtonImage = UIImage(named: "back_all_b_s")
    
    /// 手势代理
    var popGestureDelegate: UIGestureRecognizerDelegate?
    
    /// 子控制器,真正展示页面的
    var ghViewControllers: [UIViewController] {
        get {
            var vcA = [UIViewController]()
            for vc in viewControllers {
                let wVc = vc as! WrapViewController
                vcA.append(wVc.rootViewController!)
            }
            return vcA
        }
    }
    
    
    /// 初始化方法
    ///
    /// - Parameter rootViewController: r
    override init(rootViewController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        rootViewController.gh_navigation_controller = self
        self.viewControllers = [WrapViewController(viewController: rootViewController)]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 隐藏总导航栏,使用自定义的
        isNavigationBarHidden = true
        // 导航栏代理
        delegate = self
        // 边缘侧滑代理
        popGestureDelegate = interactivePopGestureRecognizer?.delegate
    }
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    
}

extension NavigationController: UINavigationControllerDelegate {
    
    /// 即将展示
    ///
    /// - Parameters:
    ///   - navigationController: n
    ///   - viewController: v
    ///   - animated: a
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        let isRootVc = viewController == navigationController.viewControllers.first
        interactivePopGestureRecognizer?.delegate = self
        interactivePopGestureRecognizer?.isEnabled = !isRootVc
    }
    
}

extension NavigationController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let topWrapVc = topViewController as! WrapViewController
        let topVc = topWrapVc.rootViewController!
        if topVc.conforms(to: NavigationControllerShouldPopProtocol.self) {
            
            let topVcP = topVc as! NavigationControllerShouldPopProtocol
            
            if !topVcP.navigationControllerShouldStartInteractivePopGestureRecognizer!(navigationController: self) {
                return false
            }
        }
        return popGestureDelegate!.gestureRecognizerShouldBegin!(gestureRecognizer)
    }
    /// 修复有水平方向滚动的ScrollView时边缘返回手势失效的问题
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer.isKind(of: UIScreenEdgePanGestureRecognizer.self)
    }
    
}

