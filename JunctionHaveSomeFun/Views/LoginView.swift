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
        HStack {
            Color.clear
            VStack {
                TextField("아이디", text: $idTextField)
                    .frame(height: 40)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .textFieldStyle(.plain)
                TextField("비밀번호", text: $idTextField)
            }
        }
    }
}

#Preview {
    LoginView()
        .frame(width: 800, height: 600)
}
