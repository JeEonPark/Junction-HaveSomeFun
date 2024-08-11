//
//  LocationSelectView.swift
//  JunctionHaveSomeFun
//
//  Created by taehun on 8/11/24.
//

import SwiftUI

enum Location {
    case 구룡포읍
    case 기계면
    case 기북면
    case 대송면
    case 대이동
    case 동해면
    case 두호동
    case 상대동
    case 송도동
    
    case 송라면
    case 신광면
    case 양학동
    case 연일읍
    case 오천읍
    case 용흥동
    case 우창동
    case 장기면
    case 장량동
    
    case 제철동
    case 죽도동
    case 죽장면
    case 중앙동
    case 청림동
    case 청하면
    case 해도동
    case 호미곶면
    case 환여동
    case 효곡동
    case 흥해읍
}

struct LocationSelectView: View {
    
    @Binding var recommendPopover: Bool
    @Binding var location: String
    @State var locationArray: [String] = ["구룡포읍", "기계면", "기북면", "대송면", "대이동", "동해면", "두호동", "상대동", "송도동", "송라면", "신광면", "양학동", "연일읍", "오천읍", "용흥동", "우창동", "장기면", "장량동", "제철동", "죽도동", "중앙동", "청림동", "청하면", "해도동", "호미곶면", "환여동", "효곡동", "흥해읍"
    ]
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(locationArray, id: \.self) { loc in
                    Button(action: {
                        location = loc
                        print(loc)
                        recommendPopover.toggle()
                    }) {
                        Text(loc)
                            .font(Font.custom("Apple SD Gothic Neo", size: 16))
                            .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
                            .padding(EdgeInsets(top: 12.5, leading: 72, bottom: 12.5, trailing: 72))
                    }
//              //      .buttonStyle(.plain)
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
    LocationSelectView(recommendPopover: .constant(true), location: .constant(""))
}
