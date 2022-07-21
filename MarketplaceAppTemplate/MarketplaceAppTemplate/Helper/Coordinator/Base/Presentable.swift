//
//  Presentable.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara on 19/07/22  .
//

import Foundation
import UIKit

protocol Presentable {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
    
    func toPresent() -> UIViewController? {
        return self
    }
}
