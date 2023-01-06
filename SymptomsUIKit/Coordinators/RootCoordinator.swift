//
//  RootCoordinator.swift
//  SymptomsUIKit
//
//  Created by Dermot O'Sullivan on 5/1/2023.
//

import Foundation
import UIKit

enum Screen {
    case root
    case sampleEntry
}

protocol Navigator {

    func moveTo(_ screen: Screen, animated: Bool)
}

final class RootCoordinator {
    
    var navigationController: UINavigationController?
    
    func start() -> UINavigationController {
        let listViewController = SymptomListViewController(coordinator: self)
        let navController = UINavigationController(rootViewController: listViewController)
        self.navigationController = navController
        return navController
        
    }
}

extension RootCoordinator: Navigator {
    
    func moveTo(_ screen: Screen, animated: Bool = true) {
        switch screen {
        case .root:
            navigationController?.popViewController(animated: animated)

        case .sampleEntry:
            fatalError()
//            navigationController?.present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>)
        }
    }

}
