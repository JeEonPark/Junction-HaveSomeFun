//
//  FilterView.swift
//  JunctionHaveSomeFun
//
//  Created by taehun on 8/10/24.
//

import SwiftUI

struct SearchView: View {
    @State var locationPopover = false
    @State var location = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            
            //                TextField("Select a location", text: $location)
            Button(action: {
                locationPopover.toggle()
            }, label: {
                HStack {
                    Image("bxs_map")
                        .resizable()
                        .frame(width: 32, height: 32)
                    if location == "" {
                        Text("Select a location")
                    } else {
                        Text(location)
                    }
                }
            })
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 0)
        .frame(width: 320, height: 50, alignment: .leading)
        .background(.white)
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.25), radius: 5, x: 4, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .inset(by: 0.75)
                .stroke(Color(red: 0, green: 0.39, blue: 0.86), lineWidth: 1.5)
        )
        .popover(isPresented: $locationPopover, attachmentAnchor: .point(.center), arrowEdge: .top) {
            LocationSelectView(recommendPopover: $locationPopover, location: $location)
                .frame(width: 244, height: 466)
        }
    }
}

#Preview {
    SearchView()
}
