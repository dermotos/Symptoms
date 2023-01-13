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
    case sampleEntry(Int)
    case addTrackedSymptoms(TrackedSymptomViewModel)
}

protocol Navigator {
    func navigateTo(_ screen: Screen, animated: Bool)
}

final class RootCoordinator {

    var healthStore: HealthStorable
    var configStore: ConfigurationStorable
    
    var navigationController: UINavigationController?
    
    var symptomListViewController: SymptomListViewController? {
        navigationController?.viewControllers.first as? SymptomListViewController
    }
    
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
        
        let navigationController = makeRootNavigationController(containing: listViewController)
        self.navigationController = navigationController
        return navigationController
    }
    
    private func makeRootNavigationController(containing rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.prefersLargeTitles = false
        return navigationController
    }
}

extension RootCoordinator: Navigator {
    
    func navigateTo(_ screen: Screen, animated: Bool = true) {
        switch screen {
        case .root:
            refreshSymptomList()
            navigationController?.presentedViewController?.dismiss(animated: animated)
            navigationController?.popViewController(animated: animated)

        case .sampleEntry(let index):
            navigationController?.presentedViewController?.dismiss(animated: animated)
            guard let modelProvider = symptomListViewController else {
                return
            }
            let sampleEntryViewController = SampleEntryViewController(modelProvider: modelProvider, startingIndex: index)
            navigationController?.pushViewController(sampleEntryViewController, animated: true)

        case .addTrackedSymptoms(let model):
            let addTrackedSymptoms = AddSymptomViewController(coordinator: self, model: model)
            let containingController = UINavigationController(rootViewController: addTrackedSymptoms)
            navigationController?.present(containingController, animated: true)
        }
    }
    
    private func refreshSymptomList() {
        symptomListViewController?.refreshTable()
    }
}
