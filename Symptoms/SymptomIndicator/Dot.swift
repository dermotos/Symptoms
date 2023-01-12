//
//  Dot.swift
//  Symptoms
//
//  Created by Dermot O'Sullivan on 11/1/2023.
//

import SwiftUI

enum SymptomLevel: Int {
    case notPresent = 0
    case present
    case mild
    case moderate
    case severe
}

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
    @State var level: SymptomLevel
    
    var color: Color {
        level == .notPresent ? .gray : .red
    }
    
    var sizeStep: CGFloat {
        let scaleForLevel: [SymptomLevel: CGFloat] =
        [.notPresent: 0.1,
         .present: 0.15,
         .mild: 0.3,
         .moderate: 0.5,
         .severe: 0.6]
        return scaleForLevel[level, default: 0.3]
    }
    
    var body: some View {
        GeometryReader { geometry in
            Circle()
                .foregroundColor(color)
                .scaleEffect(sizeStep)
                .animation(.easeInOut, value: level)
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
    @State var level: SymptomLevel
    
    var sizeStep: CGFloat {
        let scaleForLevel: [SymptomLevel: CGFloat] =
        [.notPresent: 0.1,
         .present: 0.15,
         .mild: 0.3,
         .moderate: 0.5,
         .severe: 0.6]
        return scaleForLevel[level, default: 0.3]
    }
    
    func numberOfSpikes() -> Int {
        switch level {
        case .notPresent,
                .present,
                .mild:
            return 5
        case .moderate:
            return 7
        case .severe:
            return 10
        }
    }
    
    var spikes: some View {
        ForEach(0..<numberOfSpikes(), id: \.self) { index in
            RotatedSpike(angle: .degrees(Double(index) / Double(numberOfSpikes()) * 360.0))
        }
    }
    
    var body: some View {
        ZStack {
            spikes
                .scaleEffect(1.0, anchor: .center)
                .scaledToFit()
                .border(Color.green, width: 1)
                .scaleEffect(sizeStep)
                
            Dot(level: level)
                //.scaledToFit()
                .border(Color.red, width: 1)
                .opacity(0.2)
            }
            
        
        
    }
    
}

struct Dot_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Dot(level: .present)
            Spike().previewDisplayName("Spike")
            RotatedSpike(angle: Angle(degrees: 15)).previewDisplayName("Rotated")
            SymptomIndicator(level: .severe).previewDisplayName("Indicator")
        }
        
    }
}


