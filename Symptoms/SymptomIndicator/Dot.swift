//
//  Dot.swift
//  Symptoms
//
//  Created by Dermot O'Sullivan on 11/1/2023.
//

import SwiftUI

struct Dot: View {
    @State var level: Int = 4
    @State var sliderValue: CGFloat = 4
    
    var color: Color {
        level == 0 ? .gray : .red
    }
    
    var sizeStep: CGFloat {
        let scaleForLevel: [Int: CGFloat] =
        [0: 0.1,
         1: 0.15,
         2: 0.3,
         3: 0.5,
         4: 0.6]
        return scaleForLevel[level, default: 0.3]
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Circle()
                    .foregroundColor(color)
                    .scaleEffect(sizeStep)
                    .animation(.easeInOut, value: level)
            }
            Slider(
                    value: $sliderValue,
                    in: 0...4,
                    step: 1) { _ in
                        level = Int(sliderValue)
                    }
        }
       
    }
}

struct Dot_Previews: PreviewProvider {
    static var previews: some View {
        Dot()
    }
}
