//
//  SymptomsApp.swift
//  Symptoms
//
//  Created by Dermot O'Sullivan on 31/12/2022.
//

import SwiftUI
import HealthStore

@main
struct SymptomsApp: App {
    @StateObject var viewModel = ViewModel(configuration: ConfigurationStore(filename: "tracked-symptoms.json").load())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }

}
