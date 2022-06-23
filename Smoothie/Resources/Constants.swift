//
//  Constants.swift
//  Smoothie
//
//  Created by User on 23/06/22.
//

import Foundation
import UIKit

class Common {
    static let shared = Common()
    let dashboard = "Dashboard"
    func getWebController() -> WebViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if   let webViewController = storyboard.instantiateViewController(withIdentifier: "WebViewController")  as? WebViewController{
            return webViewController
        }
        else{
            return  WebViewController()
        }
    }
}

class Constants {
    static let shared = Constants()
    let dashboardTitle = "Dashboard"
    let webviewTitle = "WebView"
    
}
