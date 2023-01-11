//
//  RootCoordinator.swift
//  SymptomsUIKit
//
//  Created by Dermot O'Sullivan on 5/1/2023.
//

import Foundation
import UIKit
import HealthStore

enum Screen {
    case root
    case sampleEntry
    case addTrackedSymptoms
}

protocol Navigator {
    func navigateTo(_ screen: Screen, animated: Bool)
}

final class RootCoordinator {

    var healthStore: HealthStorable
    var configStore: ConfigurationStorable
    
    var navigationController: UINavigationController?
    
    init(healthStore: HealthStorable,
         configStore: ConfigurationStorable) {
        self.healthStore = healthStore
        self.configStore = configStore
    }
    
    func start() -> UINavigationController {
        let listViewController =
        SymptomListViewController(coordinator: self,
                                  healthStore: healthStore,
                                  configStore: configStore)
        let navController = UINavigationController(rootViewController: listViewController)
        self.navigationController = navController
        return navController
        
    }
}

extension RootCoordinator: Navigator {
    
    func navigateTo(_ screen: Screen, animated: Bool = true) {
        switch screen {
        case .root:
            navigationController?.popViewController(animated: animated)

        case .sampleEntry:
            fatalError()

        case .addTrackedSymptoms:
            fatalError()
//            let addTrackedSymptomViewController = AddSymptomViewController(coordinator: self, healthStore: healthStore, trackedSymptoms: <#T##[HKCategoryTypeIdentifier]#>)
//            navigationController?.present
        }
    }

}
