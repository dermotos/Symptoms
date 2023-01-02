//
//  HealthStore.swift
//  Symptoms
//
//  Created by Dermot O'Sullivan on 31/12/2022.
//

import Foundation
import HealthKit

protocol HealthStore {
    
    var isAvailable: Bool { get }
    
    func authorizationStatus(forWriting type: HKCategoryType) -> HKAuthorizationStatus
    
    func requestAuthorization(for readWrite: Set<HKCategoryType>, readOnly: Set<HKCategoryType>) async throws -> String?
    
    func recordSample(_ sample: HKCategoryValueSeverity,_ category: HKCategoryTypeIdentifier, date: Date, duration: TimeInterval)
    
    //func read
}

extension HKHealthStore: HealthStore {
    func requestAuthorization(for readWrite: Set<HKCategoryType>, readOnly: Set<HKCategoryType>) async -> String? {
        do {
            try await self.requestAuthorization(toShare: readWrite, read: readOnly)
        } catch {
            
        }
        return "fixme"
    }
    
    func authorizationStatus(forWriting type: HKCategoryType) -> HKAuthorizationStatus {
        self.authorizationStatus(for: type)
    }

    var isAvailable: Bool {
        HKHealthStore.isHealthDataAvailable()
    }
    
    func recordSample(_ sample: HKCategoryValueSeverity, _ category: HKCategoryTypeIdentifier, date: Date, duration: TimeInterval) {
        
    }
    
    
}

final class HealthKitService {
    
    private var healthStore: HealthStore
    
    init(healthStore: HealthStore = HKHealthStore()) {
        self.healthStore = healthStore
    }
    
    var isAvailable: Bool {
        healthStore.isAvailable
    }
    
    func requestAccess() {
        
    }
    
    func readValues() {
        
    }
    
//    func writeValues() {
//        let identifier = HKCategoryTypeIdentifier.headache
//       // let category = HKCategoryType(identifier)
//        let severity: HKCategoryValueSeverity = .severe
//        //HKCategoryValueSeverity
//        
//        let sample = HKCategoryValueSeverity.
//        let sample = HKCategorySample(type:identifier , value: <#T##Int#>, start: <#T##Date#>, end: <#T##Date#>)
//    }
}
