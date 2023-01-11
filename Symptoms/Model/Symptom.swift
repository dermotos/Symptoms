//
//  Symptom.swift
//  Symptoms
//
//  Created by Dermot O'Sullivan on 3/1/2023.
//

import Foundation
import HealthKit
import SwiftUI

struct Symptom: Hashable, Identifiable {
    var id: HKCategoryTypeIdentifier
    var name: String
}

extension Symptom: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

typealias Symptoms = [Symptom]

extension Symptoms: Previewable {
    static let previewData: Symptoms = {
        [Symptom(id: .headache, name: "Headache"),
         Symptom(id: .heartburn, name: "Heartburn")]
    }()
}


