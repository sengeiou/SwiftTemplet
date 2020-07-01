//
//  NNWebView.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/7/5.
//  Copyright © 2019 BN. All rights reserved.
//

import UIKit
import WebKit

@objc protocol NNWebViewDelegate: NSObjectProtocol {
    @objc optional func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void);

}

@objc class NNWebView: UIView {
    
    weak var delegate: NNWebViewDelegate?
   
    var urlString: String = ""{
        willSet{
            DispatchQueue.main.async{
                self.loadRequest()
            }
        }
    }
    var jsString: String = ""
    var loadingProgressColor: UIColor = UIColor.systemBlue {
        willSet{
            progress.progressTintColor = newValue
        }
    }
    
    var loadContent: String = ""{
        willSet{
            webView.loadHTMLString(newValue, baseURL: nil)
        }
    }

    ///展示重载按钮
    var showReloadBtn: Bool = false
    
    deinit {
        reloadBtn.removeObserver(webView, forKeyPath: "hidden")
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.stopLoading()
        webView.uiDelegate = nil
        webView.navigationDelegate = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white;
        self.addSubview(reloadBtn)
        self.addSubview(webView)
        self.addSubview(progress)
        
        progress.progressTintColor = loadingProgressColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        progress.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 2)
        webView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        reloadBtn.center = webView.center;
    }
    
    //MARK: -observe

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progress.setProgress(Float(webView.estimatedProgress), animated: true)
            if webView.estimatedProgress >= 1 {
                progress.isHidden = true
                refreshControl.endRefreshing()
            }
            
        } else if keyPath == "hidden" {
            if let newValue = change![NSKeyValueChangeKey.newKey] as? NSNumber {
                if newValue == true {
                    bringSubviewToFront(reloadBtn)
                } else {
                    sendSubviewToBack(reloadBtn)
                }
            }
        }
    }
    
    @objc func loadRequest() {
        assert(urlString != "")
        if !urlString.hasPrefix("http") {
            urlString = "http://" + urlString;
        }
        if urlString != "", let url = NSURL(string: urlString) as NSURL? {
            let request = URLRequest(url: url as URL)
            webView.load(request)
        } else {
            print("\(#function) 链接无效:\(urlString)")
        }
    }
    
    @objc func webViewReload() {
        webView.reload()
    }
    
    @objc func back(_ item: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
   
    //MARK: -lazy
    lazy var webView: WKWebView = {
        let view = WKWebView(frame: bounds, configuration: WKWebView.confiDefault)
        view.uiDelegate = self
        view.navigationDelegate = self
        view.allowsBackForwardNavigationGestures = true
        view.scrollView.showsHorizontalScrollIndicator = false
        view.scrollView.showsVerticalScrollIndicator = true
        if #available(iOS 10.0, *) {
            view.scrollView.refreshControl = self.refreshControl;
        }
        
        view.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        return view
    }()

    lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action:#selector(loadRequest), for: .valueChanged)
        return view
    }()
    
    lazy var progress: UIProgressView = {
        let view: UIProgressView = UIProgressView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: 2))
        return view
    }()
    
    lazy var reloadBtn: UIButton = {
        let view = UIButton(type: .custom)
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        view.setTitle("重新加载", for: .normal)
        view.setTitleColor(UIColor.red, for: .normal)
        view.addTarget(self, action: #selector(loadRequest), for: .touchUpInside)
        
        view.addObserver(webView, forKeyPath: "hidden", options: .new, context: nil)
        return view
    }()
}

extension NNWebView: WKUIDelegate{
    //MARK: -webView
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if showReloadBtn {
            webView.isHidden = false
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.title") { (obj, error) in
//            print(obj)
        }
        refreshControl.endRefreshing()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if delegate == nil {
            decisionHandler(.allow)
            return
        }
        delegate?.webView?(webView, decidePolicyFor: navigationAction, decisionHandler: decisionHandler)
    }
}

extension NNWebView: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        if showReloadBtn {
//            webView.isHidden = true
        }
//        UIAlertController.showAlert("提示", msg: error.localizedDescription, actionTitles: nil, handler: nil);
//        IOPProgressHUD.showError(withStatus: error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        if showReloadBtn {
//            webView.isHidden = true
        }
//        UIAlertController.showAlert("提示", msg: error.localizedDescription, actionTitles: nil, handler: nil);
//        IOPProgressHUD.showError(withStatus: error.localizedDescription)
    }
}

extension NNWebView: WKScriptMessageHandler{
    //MARK: -WKScriptMessageHandler js 拦截 调用OC方法
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message)
//        let methodStr = message.name + ":"
//        let selector = NSSelectorFromString(methodStr)
//        if self.responds(to: selector) {
//            self.perform(selector)
//        } else {
//            print("未实行方法-", methodStr)
//        }
    }
}
