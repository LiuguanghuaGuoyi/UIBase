//
//  UserInterfaceAdaptor.swift
//  YunShangMall
//
//  Created by 刘光华 on 2019/5/15.
//  Copyright © 2019 YunShangMall. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height
let naviBarHeight: CGFloat = isIPhoneXSeries() ? 88 : 64
let tabBarHeight: CGFloat = isIPhoneXSeries() ? 83 : 49

/// UI设计图的宽度（dp）
let uiDesignW: CGFloat = 360

/// 判断是不是iPhone X系列,留海屏
///
/// - Returns: b
func isIPhoneXSeries() -> Bool {
    var iPhoneXSeries: Bool = false
    if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone {
        return iPhoneXSeries
    }
    let mainWindow = UIApplication.shared.keyWindow!
    if #available(iOS 11.0, *) {
        if mainWindow.safeAreaInsets.bottom > 0 {
            iPhoneXSeries = true
        }
    }
    return iPhoneXSeries
}

/// 屏幕宽比
func adationRatio() -> CGFloat {
    return screenWidth / uiDesignW
}
/// 适配长度
func adation(_ length: CGFloat) -> CGFloat {
    return length * adationRatio()
}

/// 适配字体
func adationFont(_ fontSize: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: fontSize * adationRatio())
}
/// 适配粗体
func adationBoldFont(_ fontSize: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: fontSize * adationRatio())
}
