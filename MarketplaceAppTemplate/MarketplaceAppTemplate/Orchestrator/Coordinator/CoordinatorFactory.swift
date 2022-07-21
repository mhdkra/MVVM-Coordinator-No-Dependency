//
//  CoordinatorFactory.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara on 19/07/22.
//

import Foundation
import UIKit

protocol CoordinatorFactory {
    // MARK: - Main
    func makeMainCoordinator(router: Router) -> Coordinator & MainCoordinatorOutput
}
