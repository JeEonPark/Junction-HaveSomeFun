//
//  ContentView.swift
//  JunctionHaveSomeFun
//
//  Created by DevJonny on 2024/8/10.
//

import SwiftUI

struct ContentView: View {
    @State private var helloWorldMessage: String = ""
    @State private var errorMessage: String?
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            let serverManager = ServerManager()
            serverManager.fetchHelloWorld { result in
                switch result {
                case .success(let message):
                    helloWorldMessage = message
                    print(message)
                case .failure(let error):
                    errorMessage = error.localizedDescription
                    print(error)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
