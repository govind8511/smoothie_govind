//
//  WebViewController.swift
//  Smoothie
//
//  Created by User on 21/06/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var url = String()
    
    @IBOutlet weak var wkWebview: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.shared.webviewTitle
        let request = URLRequest(url: URL(string: url)!)
        wkWebview?.load(request)
    }
}
