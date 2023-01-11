//
//  ViewModel.swift
//  Symptoms
//
//  Created by Dermot O'Sullivan on 3/1/2023.
//

import Foundation
import HealthStore

typealias SymptomRecords = [Symptom: Int?]

final class ViewModel: ObservableObject {
    @Published var trackedSymptoms: Symptoms
    @Published var records: SymptomRecords
    
    fileprivate init(trackedSymptoms: Symptoms, records: SymptomRecords) {
        self.trackedSymptoms = trackedSymptoms
        self.records = records
        
    }
    
    init(configuration: ConfigurationData) {
        var records = SymptomRecords()
        var trackedSymptomTypes = Symptoms()
        for (_, element) in configuration.trackedSymptoms.enumerated() {
            let symptom = Symptom(id: element, name: element.rawValue)
            records[symptom] = nil
            trackedSymptomTypes.append(symptom)
        }
        
        self.records = records
        self.trackedSymptoms = trackedSymptomTypes
    }
    
    func save() {
        fatalError("Not implemented yet")
    }
}

extension ViewModel: Previewable {
    static var previewData: ViewModel {
        let symptoms = Symptoms.previewData
        let records = symptoms.reduce(into: SymptomRecords()) {
            $0[$1] = nil
        }
        return ViewModel(trackedSymptoms: symptoms, records: records)
    }
}
