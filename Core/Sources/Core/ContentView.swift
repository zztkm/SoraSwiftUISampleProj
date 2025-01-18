//
//  ContentView.swift
//
//  Created by zztkm on 2025/01/18.
//

import SwiftUI

public struct ContentView: View {
    public var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
    
    public init() {}
}

#Preview {
    ContentView()
}
