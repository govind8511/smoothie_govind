//
//  ViewController+Extension.swift
//  Smoothie
//
//  Created by User on 22/06/22.
//

import Foundation
import UIKit

// #MARK:- Loading image from URL
extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }
        
        do {
            self.init(data: try Data(contentsOf: url))
        } catch {
            print("Cannot load image from url: \(url) with error: \(error)")
            return nil
        }
    }
}
