//
//  FilterView.swift
//  JunctionHaveSomeFun
//
//  Created by taehun on 8/10/24.
//

import SwiftUI

struct FilterView: View {
    
    @State var recommendSetting = false
    @State var recommendPopover = false
    @State var location = ""
    
    @State var timePopover = false
    @State var time = ""
    @State var population: Double = 1
    
    @State var lightingNotSet = false
    @State var lighting: Double = 1
    
    @State var noiseNotSet = false
    @State var noise: Double = 1
    @State var times: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"
    ]
    //    @State var industry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            //Filters
            Text("Filters")
                .font(
                    Font.custom("SF Pro", size: 20)
                        .weight(.semibold)
                )
                .foregroundColor(.black)
                .padding(EdgeInsets(top: 22, leading: 23, bottom: 15.5, trailing: 8))
            
            HStack(spacing: 0) {
                Spacer()
                
                Button(action: {
                    recommendSetting.toggle()
                }, label: {
                    if recommendSetting == false {
                        Text("Recommended Settings by Industry")
                            .font(Font.custom("SF Pro", size: 14))
                            .foregroundColor(.black)
                        
                        Image(systemName: "square")
                            .resizable()
                            .frame(width: 14, height: 14)
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    } else {
                        Text("Recommended Settings by Industry")
                            .font(Font.custom("SF Pro", size: 14))
                            .foregroundColor(.mainBlue)
                        
                        Image(systemName: "checkmark.square.fill")
                            .resizable()
                            .frame(width: 14, height: 14)
                            .foregroundColor(.mainBlue)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                })
                
                Spacer()
            }
            
            Button(action: {
                recommendPopover.toggle()
            }, label: {
                Text("No Selection")
                    .font(Font.custom("SF Pro", size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0, green: 0.39, blue: 0.86))
                    .frame(maxWidth: .infinity, alignment: .top)
            })
            .disabled(!recommendSetting)
            .frame(width: 280, height: 50, alignment: .center)
            .background(Color.clear)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0, green: 0.39, blue: 0.86), lineWidth: 1))
            .padding(EdgeInsets(top: 11.5, leading: 24, bottom: 26, trailing: 24))
            .opacity(recommendSetting ? 1 : 0.3)
            .popover(isPresented: $recommendPopover, attachmentAnchor: .point(.trailing), arrowEdge: .leading) {
                CategorySelectionView()
                    .presentationCompactAdaptation(.popover)
            }
            Divider()
                .padding(.horizontal, 20)
            
            //Time
            HStack(spacing: 0) {
                Text("Time")
                    .font(
                        Font.custom("SF Pro", size: 16)
                            .weight(.semibold)
                    )
                    .foregroundColor(Color(red: 0, green: 0.17, blue: 0.43))
                Text("*")
                    .font(Font.custom("SF Pro", size: 20))
                    .foregroundColor(Color(red: 1, green: 0.38, blue: 0.25))
            }                 
                .padding(EdgeInsets(top: 39, leading: 25, bottom: 0, trailing: 8))
            HStack(spacing: 0) {
//                Picker("Select a time", selection: $time) {
//                    ForEach(0 ..< times.count) {
//                                   Text(self.times[$0])
//                               }
//                           }
                
                Button(action: {
                    timePopover.toggle()
                }, label: {
                    if time == "" {
                        Text("Select a time")
                            .font(Font.custom("SF Pro", size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0, green: 0.39, blue: 0.86))
                    } else {
                        Text(time)
                            .font(Font.custom("SF Pro", size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0, green: 0.39, blue: 0.86))
                    }
                })
               
            }
            .frame(width: 280, height: 50, alignment: .center)
            .background(Color.clear)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0, green: 0.39, blue: 0.86), lineWidth: 1))
            .popover(isPresented: $timePopover, attachmentAnchor: .point(.center), arrowEdge: .top) {
                
                
                TimeSelectView(timePopover: $timePopover, time: $time)
            }
            .padding(EdgeInsets(top: 8.5, leading: 24, bottom: 0, trailing: 24))

            //population
            HStack(spacing: 0) {
                Text("Floating Population")
                    .font(
                        Font.custom("SF Pro", size: 16)
                            .weight(.semibold)
                    )
                    .foregroundColor(Color(red: 0, green: 0.17, blue: 0.43))
                
                Text("*")
                    .font(Font.custom("SF Pro", size: 20))
                    .foregroundColor(Color(red: 1, green: 0.38, blue: 0.25))
            }
            .padding(EdgeInsets(top: 32.5, leading: 25, bottom: 0, trailing: 8))
            
            Slider(value: $population, in: 0...2, step: 1.0)
                .padding(EdgeInsets(top: 8, leading: 30, bottom: 0, trailing: 30))
            
            ZStack {
                HStack(spacing: 0) {
                    Text("Low")
                    Spacer()
                    Text("High")
                }
                .frame(width: .infinity)
                Text("Medium")
            }
            .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
            .font(Font.custom("SF Pro", size: 14))
            .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
            
            //lighting
            HStack(spacing: 0) {
                Text("Lighting")
                    .font(
                        Font.custom("SF Pro", size: 16)
                            .weight(.semibold)
                    )
                    .foregroundColor(Color(red: 0, green: 0.17, blue: 0.43))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
                
                Button(action: {
                    lightingNotSet.toggle()
                }, label: {
                    if lightingNotSet == false {
                        Image(systemName: "square")
                            .resizable()
                            .frame(width: 14, height: 14)
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        Text("Not set")
                            .font(Font.custom("SF Pro", size: 14))
                            .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                    } else {
                        Image(systemName: "checkmark.square.fill")
                            .resizable()
                            .frame(width: 14, height: 14)
                            .foregroundColor(Color.secondaryOrange)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        Text("Not set")
                            .font(Font.custom("SF Pro", size: 14))
                            .foregroundColor(Color.secondaryOrange)
                    }
                })
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .padding(EdgeInsets(top: 41, leading: 24, bottom: 0, trailing: 0))
            
            ZStack {
                VStack(spacing: 0) {
                    Slider(value: $lighting, in: 0...2, step: 1.0)
                        .padding(EdgeInsets(top: 8, leading: 30, bottom: 0, trailing: 30))
                    
                    ZStack {
                        HStack(spacing: 0) {
                            Text("Dark")
                            Spacer()
                            Text("Bright")
                        }
                        .frame(width: .infinity)
                        Text("Moderate")
                    }
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                    .font(Font.custom("SF Pro", size: 14))
                    .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                }
                
                Rectangle()
                    .frame(width: .infinity, height: 55)
                    .foregroundColor(.white)
                    .opacity(lightingNotSet ? 0.7 : 0)
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))

            }
            
            HStack(spacing: 0) {
                Text("Noise")
                    .font(
                        Font.custom("SF Pro", size: 16)
                            .weight(.semibold)
                    )
                    .foregroundColor(Color(red: 0, green: 0.17, blue: 0.43))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
                
                Button(action: {
                    noiseNotSet.toggle()
                }, label: {
                    if noiseNotSet == false {
                        Image(systemName: "square")
                            .resizable()
                            .frame(width: 14, height: 14)
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        Text("Not set")
                            .font(Font.custom("SF Pro", size: 14))
                            .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                    } else {
                        Image(systemName: "checkmark.square.fill")
                            .resizable()
                            .frame(width: 14, height: 14)
                            .foregroundColor(Color.secondaryOrange)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        Text("Not set")
                            .font(Font.custom("SF Pro", size: 14))
                            .foregroundColor(Color.secondaryOrange)
                    }
                })
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .padding(EdgeInsets(top: 40, leading: 24, bottom: 0, trailing: 0))
            
            ZStack {
                VStack(spacing: 0) {
                    Slider(value: $noise, in: 0...2, step: 1.0)
                        .padding(EdgeInsets(top: 8, leading: 30, bottom: 0, trailing: 30))
                    
                    ZStack {
                        HStack(spacing: 0) {
                            Text("Quiet")
                            Spacer()
                            Text("Noisy")
                        }
//                        .frame(width: .infinity)
                        Text("Moderate")
                    }
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                    .font(Font.custom("SF Pro", size: 14))
                    .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                }
                Rectangle()
                    .frame(width: .infinity, height: 55)
                    .foregroundColor(.white)
                    .opacity(noiseNotSet ? 0.7 : 0)
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
            }
            
            Spacer()
            
            Button(action: {
                lightingNotSet.toggle()
            }, label: {
                Text("Apply")
                    .font(
                        Font.custom("SF Pro", size: 20)
                            .weight(.semibold)
                    )
                    .foregroundColor(.white)
            })
            .frame(width: 280, height: 50, alignment: .center)
            .background(Color.mainBlue)
            .cornerRadius(8)
            .padding(EdgeInsets(top: 30, leading: 24, bottom: 19, trailing: 24))
            
        }
        .foregroundColor(.clear)
        .frame(width: 320, height: 826)
        .background(.white)
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.25), radius: 5, x: 4, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .inset(by: 0.75)
                .stroke(Color(red: 0, green: 0.39, blue: 0.86), lineWidth: 1.5)
        )
        
    }
}

#Preview {
    FilterView()
}
