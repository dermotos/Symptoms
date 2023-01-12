//
//  Dot.swift
//  Symptoms
//
//  Created by Dermot O'Sullivan on 11/1/2023.
//

import SwiftUI

struct Spike: View {
    var fillStyle = FillStyle()
    let gradientStart = Color("spikeGradientStart")
    let gradientEnd = Color("spikeGradientEnd")
    let startPoint = UnitPoint(x: 0.5, y: 0)
    let endPoint = UnitPoint(x: 0.5, y: 0.6)
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Path { path in
                    let reference = min(geometry.size.width, geometry.size.height)
                    let width = reference
                    let height = reference * 0.75
                    let middle = reference * 0.5
                    
                    path.addLines([
                        CGPoint(x: 0 , y: height), // bottom left
                        CGPoint(x: middle, y: 0), // middle top
                        CGPoint(x: width, y: height), // bottom right
                        CGPoint(x: 0 , y: height) // Back to bottom left
                    ])
                    
                }
                .fill(.linearGradient(colors: [gradientStart, gradientEnd], startPoint: startPoint, endPoint: endPoint))
            }
        }
    }
}

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

struct RotatedSpike: View {
    let angle: Angle
    var body: some View {
        Spike()
            .padding(-40)
            .rotationEffect(angle)
    }
}

struct SymptomIndicator: View {
    @State var level: Int
    
    var spikes: some View {
        ForEach(0..<8) { index in
            RotatedSpike(angle: .degrees(Double(index) / Double(8) * 360.0))
        }
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                spikes
                    .scaleEffect(0.25, anchor: .center)
                    .position(CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2))
                Dot()
                    .position(CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2))
            }
            
        }
    }
    
}

struct Dot_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Dot()
            Spike().previewDisplayName("Spike")
            RotatedSpike(angle: Angle(degrees: 15)).previewDisplayName("Rotated")
            SymptomIndicator(level: 4).previewDisplayName("Indicator")
        }
        
    }
}


