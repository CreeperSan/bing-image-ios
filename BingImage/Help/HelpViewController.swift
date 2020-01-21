//
//  HelpViewController.swift
//  BingImage
//
//  Created by creepersan on 2020/1/20.
//  Copyright © 2020 creepersan. All rights reserved.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTitle()
        initWebView()
    }
    
    private func initTitle(){
        self.navigationItem.title = "帮助"
    }

    private func initWebView(){
        
    }


}
