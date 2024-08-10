//
//  MapView.swift
//  JunctionHaveSomeFun
//
//  Created by taehun on 8/10/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var mapViewModel: MapViewModel = MapViewModel()
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5666791, longitude: 126.9782914), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Map(coordinateRegion: $region)
                
                HStack(spacing: 0) {
                    VStack(alignment: .leading) {
                        SearchView()
                        
                        HStack(alignment: .top, spacing: 0) {
                            FilterView()
                            
                            ZStack() {
                                Rectangle()
                                    .frame(width: 40, height: 60, alignment: .center)
                                Image(systemName: "chevron.left")
                                    .font(.title3)
                                    .padding(.horizontal, 11)
                                    .padding(.vertical, 18)  
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 11)
                            .padding(.vertical, 18)
                            .frame(width: 40, height: 60, alignment: .center)
                            .foregroundColor(Color.mainBlue)
                            .cornerRadius(8, corners: [.topRight, .bottomRight])
                            .shadow(color: .black.opacity(0.25), radius: 5, x: 4, y: 4)
                            .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                            
                        }
                    }
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 28, bottom: 0, trailing: 0))
                
            }.frame(width: geometry.size.width, height: geometry.size.height)
                .ignoresSafeArea()
        }
        .task {
//            await mapViewModel.fetchLocationInfo(time: 2, minPopulation: 0, maxPopulation: 0, minLux: 0, maxLux: 0, minDecibel: 0, maxDecibel: 0)
//            print(mapViewModel.mappingGeohashes)
//
            await mapViewModel.fetchSpotInfoAverage(latitude: 35.9518146514893, longitude: 129.366588592529, time: 5)
            print(mapViewModel.floatingPopulation ?? "")
        }
    }
}

#Preview {
    MapView()
}
