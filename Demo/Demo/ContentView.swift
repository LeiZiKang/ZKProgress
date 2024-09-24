//
//  ContentView.swift
//  Demo
//
//  Created by 雷子康 on 2024/9/23.
//

import SwiftUI
import ZKProgress

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                ItemView(title: "CircleWave") {
                    ZKProgress.CircleWave(progress: 0.64)
                        .padding()
                }
            }
            .listStyle(.plain)
            .padding(.top, 10)
            .navigationTitle("ZKProgress")
        }
    }
}

#Preview {
    ContentView()
}
