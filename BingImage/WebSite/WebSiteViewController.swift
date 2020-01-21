//
//  WebSiteViewController.swift
//  BingImage
//
//  Created by creepersan on 2020/1/20.
//  Copyright © 2020 creepersan. All rights reserved.
//

import UIKit
import WebKit

class WebSiteViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    @IBOutlet var webView: WKWebView!
    @IBOutlet var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        webView.uiDelegate = self
        initTitle()
        initRightActionButton()
        initWebView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.removeObserver(self, forKeyPath: "title")
    }
    
    private func initTitle(){
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        webView.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    private func initWebView(){
        webView.load(URLRequest.init(url: URL(string:"http://bing.creepersan.com")!))
    }
    
    private func initRightActionButton(){
        let rightBarButton = UIBarButtonItem.init(title: "后退", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.goBack))
        
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func goBack(){
        if(webView.canGoBack){
            webView.goBack()
        }
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
       //如果目标主视图不为空,则允许导航
        if (navigationAction.targetFrame?.isMainFrame ?? false) {
            self.webView.load(navigationAction.request)
        }
        return nil
    }
    
    // 标题发生改变时
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      self.navigationItem.title = self.webView.title
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressBar.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }

}
