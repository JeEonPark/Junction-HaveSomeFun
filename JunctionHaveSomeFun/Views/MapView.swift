import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var mapViewModel: MapViewModel = MapViewModel()
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.98443031, longitude: 129.32538986), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: nil, annotationItems: mapViewModel.mappingGeohashes.map { GeohashLocation(geohash: $0) }) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 20, height: 20)
                            .opacity(0.7)
                    }
                }
                .overlay(
                    MapOverlay(coordinateRegion: $region, geohashLocations: mapViewModel.mappingGeohashes.map { GeohashLocation(geohash: $0) })
                )
                .edgesIgnoringSafeArea(.all)
                
                HStack(spacing: 0) {
                    VStack(alignment: .leading) {
                        SearchView()
                        
                        HStack(alignment: .top, spacing: 0) {
                            FilterView(mapViewModel: mapViewModel)
                            
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
            await mapViewModel.fetchLocationInfo(time: 2, minPopulation: 0, maxPopulation: 0, minLux: 0, maxLux: 0, minDecibel: 0, maxDecibel: 0)
            print(mapViewModel.mappingGeohashes)
        }
    }
}

struct GeohashLocation: Identifiable {
    let id = UUID()
    let geohash: String
    
    var coordinate: CLLocationCoordinate2D {
        if let (latitude, longitude, _, _) = geohash.decodeGeohash() {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        return CLLocationCoordinate2D()
    }
    
    var polygonCoordinates: [CLLocationCoordinate2D] {
        guard let (latitude, longitude, latitudeError, longitudeError) = geohash.decodeGeohash() else {
            return []
        }
        
        let topLeft = CLLocationCoordinate2D(latitude: latitude + latitudeError, longitude: longitude - longitudeError)
        let topRight = CLLocationCoordinate2D(latitude: latitude + latitudeError, longitude: longitude + longitudeError)
        let bottomLeft = CLLocationCoordinate2D(latitude: latitude - latitudeError, longitude: longitude - longitudeError)
        let bottomRight = CLLocationCoordinate2D(latitude: latitude - latitudeError, longitude: longitude + longitudeError)
        
        return [topLeft, topRight, bottomRight, bottomLeft]
    }
}

struct MapOverlay: UIViewRepresentable {
    @Binding var coordinateRegion: MKCoordinateRegion
    let geohashLocations: [GeohashLocation]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.region = coordinateRegion
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.removeOverlays(view.overlays)
        let overlays = geohashLocations.map { location -> MKPolygon in
            MKPolygon(coordinates: location.polygonCoordinates, count: location.polygonCoordinates.count)
        }
        view.addOverlays(overlays)
        view.setRegion(coordinateRegion, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapOverlay
        
        init(_ parent: MapOverlay) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polygon = overlay as? MKPolygon {
                let renderer = MKPolygonRenderer(polygon: polygon)
                renderer.fillColor = UIColor(hexColor: "5787C0").withAlphaComponent(0.4)
                renderer.strokeColor = UIColor(hexColor: "5787C0").withAlphaComponent(0)
                renderer.lineWidth = 0
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}

extension String {
    func decodeGeohash() -> (latitude: Double, longitude: Double, latitudeError: Double, longitudeError: Double)? {
        let geohash = self.lowercased()
        let geohashBits = geohash.map { geohashCharacterToBits[$0] }.compactMap { $0 }.joined()
        guard geohashBits.count % 5 == 0 else { return nil }
        
        let (latitudeBits, longitudeBits) = geohashBits.enumerated().reduce(into: (latitude: "", longitude: "")) { partialResult, element in
            if element.offset % 2 == 0 {
                partialResult.longitude += String(element.element)
            } else {
                partialResult.latitude += String(element.element)
            }
        }
        
        let latitudeRange = decodeGeohashBits(latitudeBits, from: -90.0, to: 90.0)
        let longitudeRange = decodeGeohashBits(longitudeBits, from: -180.0, to: 180.0)
        
        let latitude = (latitudeRange.min + latitudeRange.max) / 2
        let longitude = (longitudeRange.min + longitudeRange.max) / 2
        
        return (latitude, longitude, latitudeRange.max - latitude, longitudeRange.max - longitude)
    }
    
    private func decodeGeohashBits(_ bits: String, from min: Double, to max: Double) -> (min: Double, max: Double) {
        var min = min
        var max = max
        
        for bit in bits {
            let midpoint = (min + max) / 2
            if bit == "1" {
                min = midpoint
            } else {
                max = midpoint
            }
        }
        
        return (min, max)
    }
}

private let geohashCharacterToBits: [Character: String] = [
    "0": "00000", "1": "00001", "2": "00010", "3": "00011",
    "4": "00100", "5": "00101", "6": "00110", "7": "00111",
    "8": "01000", "9": "01001", "b": "01010", "c": "01011",
    "d": "01100", "e": "01101", "f": "01110", "g": "01111",
    "h": "10000", "j": "10001", "k": "10010", "m": "10011",
    "n": "10100", "p": "10101", "q": "10110", "r": "10111",
    "s": "11000", "t": "11001", "u": "11010", "v": "11011",
    "w": "11100", "x": "11101", "y": "11110", "z": "11111"
]

// Preview for SwiftUI
#Preview {
    MapView()
}
