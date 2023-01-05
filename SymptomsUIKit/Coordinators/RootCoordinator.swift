//
//  RootCoordinator.swift
//  SymptomsUIKit
//
//  Created by Dermot O'Sullivan on 5/1/2023.
//

import Foundation
import UIKit

final class RootCoordinator {
    
    var navigationController: UINavigationController?
    
    func start() -> UINavigationController {
        let listViewController = SymptomListViewController()
        let navController = UINavigationController(rootViewController: listViewController)
        self.navigationController = navController
        return navController
        
    }
}
