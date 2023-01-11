//
//  TrackedSymptomModel.swift
//  SymptomsUIKit
//
//  Created by Dermot O'Sullivan on 11/1/2023.
//

import Foundation
import HealthStore
import HealthKit


class TrackedSymptomViewModel {
    private var healthStore: HealthStorable
    private var configStore: ConfigurationStorable
    
    var supportedSymptoms: Symptoms
    var trackedSymptoms: Symptoms
    
    init(healthStore: HealthStorable,
         configStore: ConfigurationStorable) {
        self.healthStore = healthStore
        self.configStore = configStore
        self.supportedSymptoms = type(of: healthStore).supportedSymptoms.map { Symptom(id: $0 , name: $0.rawValue )} // TODO: Format name correctly
        self.trackedSymptoms = self.configStore.load().trackedSymptoms.map {
            Symptom(id: $0, name: $0.rawValue)
        }
    }
    
    func save(forwardToCounterpart: Bool = true) -> Bool {
        let configurationData = ConfigurationData(trackedSymptoms: trackedSymptoms.map { $0.id })
        do {
            try configStore.save(configurationData, shouldForwardToCounterpart: forwardToCounterpart)
            return true
        }
        catch {
            //TODO: Log error
            return false
        }
        
    }
}
