//
//  LoginVIew.swift
//  JunctionHaveSomeFun
//
//  Created by DevJonny on 2024/8/10.
//

import SwiftUI

struct LoginView: View {
    @State var idTextField = ""
    
    var body: some View {
        HStack (spacing: 0) {
            Color(hexColor: "D9D9D9")
                .frame(width: .infinity, height: .infinity)
                .ignoresSafeArea()
            ZStack {
                Color.white
                VStack (spacing: 0) {
                    TextField("", text: $idTextField, prompt: Text("ID").foregroundColor(.black))
                        .frame(width: 300, height: 34)
                        .padding()
                        .background(Color(hexColor: "D9D9D9"))
                        .textFieldStyle(.plain)
                        .padding(.bottom, 20)
                    TextField("", text: $idTextField, prompt: Text("Password").foregroundColor(.black))
                        .frame(width: 300, height: 34)
                        .padding()
                        .background(Color(hexColor: "D9D9D9"))
                        .textFieldStyle(.plain)
                        .padding(.bottom, 60)
                    Button(action: {
                        
                    }, label: {
                        Text("Login")
                            .foregroundColor(.black)
                            .frame(width: 300, height: 34)
                            .padding()
                            .background(Color(hexColor: "D9D9D9"))
                    })
                    .padding(.bottom, 70)
                    Button(action: {
                        // do sth
                    }, label: {
                        Text("Sign up")
                            .foregroundColor(.black)
                    })
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
