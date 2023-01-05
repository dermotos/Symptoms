//
//  ContentView.swift
//  Symptoms
//
//  Created by Dermot O'Sullivan on 31/12/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: ViewModel

    var body: some View {
        NavigationView {
            List(model.trackedSymptoms) { symptom in
                SymptomRow(symptom: symptom)
            }
            .navigationTitle("Tracked Symptoms")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel.previewData)
    }
}
