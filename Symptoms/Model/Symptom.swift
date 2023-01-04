//
//  Symptom.swift
//  Symptoms
//
//  Created by Dermot O'Sullivan on 3/1/2023.
//

import Foundation

struct Symptom: Hashable {
    var name: String
}

typealias Symptoms = [Symptom]

extension Symptoms {
    static let previewData : Symptoms = {
        [Symptom(name: "Headache"),
         Symptom(name: "Heartburn")]
    }()
}
