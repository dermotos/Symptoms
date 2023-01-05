//
//  SymptomRow.swift
//  Symptoms
//
//  Created by Dermot O'Sullivan on 3/1/2023.
//

import SwiftUI

struct SymptomRow: View {
    
    var symptom: Symptom
    
    var body: some View {
        HStack {
            Image(systemName: "staroflife.circle.fill")
            
            Text(symptom.name)
            Spacer()
        }
    }
}

struct SymptomRow_Previews: PreviewProvider {
    static let previewData = Symptoms.previewData
    static var previews: some View {
        Group {
            SymptomRow(symptom: previewData[0])
            SymptomRow(symptom: previewData[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
        
    }
        
}
