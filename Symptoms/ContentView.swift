//
//  ContentView.swift
//  Symptoms
//
//  Created by Dermot O'Sullivan on 31/12/2022.
//

import SwiftUI

struct ContentView: View {
    
    var trackedSymptoms: [Symptom]
    
    var body: some View {
        NavigationView {
            List(trackedSymptoms) { symptom in
                SymptomRow(symptom: symptom)
            }
            .navigationTitle("Tracked Symptoms")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(trackedSymptoms: Symptoms.previewData)
    }
}
