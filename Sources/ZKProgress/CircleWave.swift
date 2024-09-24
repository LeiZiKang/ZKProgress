//
//  SwiftUIView.swift
//
//
//  Created by 雷子康 on 2024/9/6.
//

import SwiftUI

extension ZKProgress {
    /// 圆形水波浪进度条
    @available(iOS 13.0, *)
    public struct CircleWave: View {
        @State private var waveOffset: Angle = .zero
        @State public var progress: Double
        @State private var xOffset: CGFloat = .zero
        
       public init(waveOffset: Angle = .zero, progress: Double, xOffset: CGFloat = .zero) {
            self.waveOffset = waveOffset
            self.progress = progress
            self.xOffset = xOffset
        }
        
        public var body: some View {
            ZStack {
                Circle().stroke(.blue, lineWidth: 2)
                WaveShape(offset: waveOffset, percent: progress, xOffset: 0)
                    .fill(.blue.opacity(0.4))
                    .clipShape (Circle())
                
                WaveShape(offset: waveOffset + .degrees(60), percent: progress, xOffset: 0.7)
                    .fill(.blue.opacity(0.4))
                    .clipShape (Circle())
                
                Text ("\(Int (progress * 100))%")
                    .font(.system(size: 140, weight: .bold, design: .rounded))
                    .foregroundColor(.blue)
            }
            .aspectRatio (1, contentMode: . fit)
            .onAppear {
                withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                    waveOffset = .init(degrees: 360)
                }
            }
        }
    }
    
    
}


@available(iOS 13.0,*)
fileprivate struct WaveShape: Shape {
    
    var offset: Angle
    var percent: Double
    var xOffset: CGFloat
    
    var animatableData: AnimatablePair<Double, CGFloat> {
        get { AnimatablePair(offset.degrees, xOffset) }
        set {
            offset = .degrees(newValue.first)
            xOffset = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let width = rect.width
            let height = rect.height
            let midHeight = height * (1 - CGFloat(percent))
            let waveHeight = height * 0.05
            
            path.move(to: CGPoint(x: 0, y: rect.maxY))
            
            for x in stride(from: 0, to: width, by: 2) {
                let relativeX = x / width
                let y = midHeight + sin((relativeX + xOffset) * Double.pi * 2 + 2 + offset.radians) * waveHeight
                path.addLine(to: CGPoint(x: x, y: y))
            }
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.closeSubpath()
        }
    }
}

