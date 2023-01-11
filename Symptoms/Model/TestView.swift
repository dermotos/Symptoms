//
//  TestView.swift
//  Symptoms
//
//  Created by Dermot O'Sullivan on 5/1/2023.
//

import SwiftUI

struct TestView: View {
    @State private var isShowingDetailView = false
    @State private var path: [Color] = []
    
    var body: some View {
        Spacer()
//        NavigationStack(path: $path) {
//            List {
//                NavigationLink("Purple", value: .purple)
//                NavigationLink("Pink", value: .pink)
//                NavigationLink("Orange", value: .orange)
//            }
//            .navigationDestination(for: Color.self) { color in
//                Text("Test")
//                    .foregroundColor(color)
//            }
//            
//        }
    }
}

struct SymptomIndicatorView: View {
    @State private var stepperValue = 2
    
    var body: some View {
        Stepper {
            Text("\(stepperValue)")
        } onIncrement: {
            stepperValue += 1
        } onDecrement: {
            stepperValue -= 1
        } onEditingChanged: { something in
            print("Editing changed")
        }

    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TestView()
                .previewDevice("Apple Watch Series 8 (45mm)")
        }
        
    }
}
