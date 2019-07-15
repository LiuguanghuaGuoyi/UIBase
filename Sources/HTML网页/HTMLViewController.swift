//
//  HTMLViewController.swift
//  QiDianTong
//
//  Created by 刘光华 on 2018/1/25.
//  Copyright © 2018年 liuguanghua. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class HTMLViewController: BaseViewController {
    var urlString: String = ""
    
    lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        config.selectionGranularity = WKSelectionGranularity.character
        let v = WKWebView(frame: CGRect.zero, configuration: config)
        v.isOpaque = false
        v.backgroundColor = UIColor.white
        v.scrollView.minimumZoomScale = 1.0
        v.scrollView.maximumZoomScale = 1.0
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if urlString == "" {
            return
        }
        MyProgressHUD.show(with: "加载中...")
        
        debugPrint(urlString)
        let encodedUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: encodedUrl)
        guard let _ = url else {
            MyProgressHUD.showError(with: "链接错误", dismissAfter: 1.0)
            return
        }
        let request = URLRequest.init(url: url!)
        webView.load(request)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        URLCache.shared.removeAllCachedResponses()
    }
    
}
extension HTMLViewController {
    func setupUI() {
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(naviBarHeight)
        }
        webView.navigationDelegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_b"), style: .plain, target: self, action: #selector(backAction))
        
        
    }
    
    @objc func backAction() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
}
extension HTMLViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        MyProgressHUD.show(with: "加载中...")
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        MyProgressHUD.dismiss()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        MyProgressHUD.showError(with: "加载失败", dismissAfter: 0.8)
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        MyProgressHUD.showError(with: "加载失败", dismissAfter: 0.8)
    }
    
}
