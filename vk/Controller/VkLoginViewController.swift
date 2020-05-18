//
//  VkLoginViewController.swift
//  vk
//
//  Created by Rafael Khanov on 12.05.2020.
//  Copyright © 2020 Rafael Khanov. All rights reserved.
//

import UIKit
import WebKit

class VkLoginViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!{
        didSet{
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7461808"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.103")
        ]
        webView.load(URLRequest(url: urlComponents.url!))
    }
}

extension VkLoginViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
                .components(separatedBy: "&")
                .map { $0.components(separatedBy: "=") }
                .reduce([String: String]()) { result, param in
                    var dict = result
                    let key = param[0]
                    let value = param[1]
                    dict[key] = value
                    return dict
            }
        let token = params["access_token"]
        let userID = params["user_id"]
        Session.shared.token = token!
        Session.shared.userID = Int(userID!)!
        
        print("access_token: " + token!)
        
        performSegue(withIdentifier: "VkLoginSegue", sender: nil)
        decisionHandler(.cancel)
        }
}
