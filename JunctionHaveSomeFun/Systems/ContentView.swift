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
    
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        if !isLoggedIn {
            LoginView(isLoggedIn: $isLoggedIn)
        } else {
            MapView()
//                .onAppear {
//                    let serverManager = ServerManager()
//                    serverManager.fetchLocationInfo(latitude: 35.9176540374756, longitude: 129.353885650635) { result in
//                        switch result {
//                        case .success(let message):
//                            helloWorldMessage = message
//                            print(message)
//                        case .failure(let error):
//                            errorMessage = error.localizedDescription
//                            print(error)
//                        }
//                    }
//                }
        }
        
    }
}

#Preview {
    ContentView()
}
