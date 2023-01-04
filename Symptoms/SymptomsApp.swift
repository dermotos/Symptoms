//
//  SymptomsApp.swift
//  Symptoms
//
//  Created by Dermot O'Sullivan on 31/12/2022.
//

import SwiftUI

@main
struct SymptomsApp: App {
    @StateObject var viewModel = ViewModel()
    
    init() {
        self.viewModel = ViewModel(sessionSymptoms: SessionSymptoms())
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(trackedSymptoms: Symptoms.previewData)
        }
    }
    
    
}
