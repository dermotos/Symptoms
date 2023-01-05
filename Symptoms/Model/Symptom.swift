//
//  Symptom.swift
//  Symptoms
//
//  Created by Dermot O'Sullivan on 3/1/2023.
//

import Foundation

struct Symptom: Hashable, Identifiable {
    var id: Int
    var name: String
}

typealias Symptoms = [Symptom]

extension Symptoms: Previewable {
    static let previewData: Symptoms = {
        [Symptom(id: 0, name: "Headache"),
         Symptom(id: 1, name: "Heartburn")]
    }()
}
