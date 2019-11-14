//
//  WebView.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 12/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import WebKit
import UIKit

final class WebViewViewController: UIViewController, WKUIDelegate {
    
    // MARK: - Outlets
    
    private lazy var webView: WKWebView = {
        return WKWebView()
    }()
    
    // MARK: - Properties
    
    var url: URL
    
    // MARK: - View life cycle
    
    init(with urlString: String) {
        url = URL(string: urlString)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
    }
}
