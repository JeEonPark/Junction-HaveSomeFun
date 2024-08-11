//
//  LocationSelectView.swift
//  JunctionHaveSomeFun
//
//  Created by taehun on 8/11/24.
//

import SwiftUI

struct TimeSelectView: View {
    
    @Binding var timePopover: Bool
    @Binding var time: String
    @State var times: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"
    ]
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(times, id: \.self) { value in
                    Button(action: {
                        time = value
                        print(value)
                        timePopover.toggle()
                    }) {
                        Text(value)
                            .font(Font.custom("Apple SD Gothic Neo", size: 16))
                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                            .padding(EdgeInsets(top: 12.5, leading: 72, bottom: 12.5, trailing: 72))
                    }
//           ////         .buttonStyle(.plain)
                    .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
                    .background(.white)
                    .overlay(
                        Rectangle()
                            .inset(by: 0.25)
                        
                            .stroke(Color(red: 0.7, green: 0.7, blue: 0.7), lineWidth: 0.5)
                    )
                }
            }
            .padding(EdgeInsets(top: 24, leading: 22, bottom: 24, trailing: 22))
            .background(Color.gray4)
        }
    }
}

#Preview {
    TimeSelectView(timePopover: .constant(true), time: .constant(""))
}
