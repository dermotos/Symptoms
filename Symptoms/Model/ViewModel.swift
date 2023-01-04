//
//  ViewModel.swift
//  Symptoms
//
//  Created by Dermot O'Sullivan on 3/1/2023.
//

import Foundation
import HealthStore

typealias SessionSymptoms = [Symptom: Int?]

class ViewModel: ObservableObject {
    @Published var sessionSymptoms: SessionSymptoms
    
    init(sessionSymptoms: SessionSymptoms) {
        self.sessionSymptoms = sessionSymptoms
    }
    
    init() {
        var configuration: ConfigurationData
        Task {
            let configurationManager = ConfigurationManager()
            guard let config = await configurationManager.load() else {
                fatalError()
            }
            configuration = configuration
        }
        self.sessionSymptoms = configuration.trackedSymptoms.reduce(into: [Symptom: Int?]()) {
            $0[Symptom(name: $1)] = nil
        }

    }
    
}
