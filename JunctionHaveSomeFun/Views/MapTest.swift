//import SwiftUI
//import MapKit
//import geohash_swift
//
//struct MapTest: View {
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
//        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//    )
//    
//    var body: some View {
//        Map(coordinateRegion: $region, overlayItems: createGridOverlay(region: region))
//            .edgesIgnoringSafeArea(.all)
//    }
//    
//    func createGridOverlay(region: MKCoordinateRegion) -> [MKPolygon] {
//        var polygons: [MKPolygon] = []
//        
//        let topLeft = CLLocationCoordinate2D(
//            latitude: region.center.latitude + region.span.latitudeDelta / 2,
//            longitude: region.center.longitude - region.span.longitudeDelta / 2
//        )
//        
//        let bottomRight = CLLocationCoordinate2D(
//            latitude: region.center.latitude - region.span.latitudeDelta / 2,
//            longitude: region.center.longitude + region.span.longitudeDelta / 2
//        )
//        
//        // 적절한 GeoHash의 길이를 결정합니다 (7자리)
//        let hashPrecision = 7
//        
//        // topLeft와 bottomRight를 포함하는 사각형 영역의 GeoHash를 계산합니다
//        let topLeftGeoHash = Geohash.encode(latitude: topLeft.latitude, longitude: topLeft.longitude, precision: hashPrecision)
//        let bottomRightGeoHash = Geohash.encode(latitude: bottomRight.latitude, longitude: bottomRight.longitude, precision: hashPrecision)
//        
//        // topLeft와 bottomRight 사이의 GeoHash 격자를 생성합니다
//        let geoHashes = Geohash.boundingBox(to: bottomRightGeoHash, from: topLeftGeoHash)
//        
//        for hash in geoHashes {
//            if let coordinates = Geohash.decode(hash) {
//                let polygon = createPolygonForGeoHash(coordinates: coordinates)
//                polygons.append(polygon)
//            }
//        }
//        
//        return polygons
//    }
//    
//    func createPolygonForGeoHash(coordinates: (latitude: Double, longitude: Double)) -> MKPolygon {
//        let delta = 0.0001 // GeoHash 크기에 따라 조정 필요
//        let topLeft = CLLocationCoordinate2D(latitude: coordinates.latitude + delta, longitude: coordinates.longitude - delta)
//        let topRight = CLLocationCoordinate2D(latitude: coordinates.latitude + delta, longitude: coordinates.longitude + delta)
//        let bottomRight = CLLocationCoordinate2D(latitude: coordinates.latitude - delta, longitude: coordinates.longitude + delta)
//        let bottomLeft = CLLocationCoordinate2D(latitude: coordinates.latitude - delta, longitude: coordinates.longitude - delta)
//        
//        return MKPolygon(coordinates: [topLeft, topRight, bottomRight, bottomLeft], count: 4)
//    }
//}
//
//struct MapOverlayView: View {
//    var overlays: [MKPolygon]
//    
//    var body: some View {
//        MapOverlay(overlays: overlays)
//    }
//}
//
//struct MapOverlay: UIViewRepresentable {
//    var overlays: [MKPolygon]
//    
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView()
//        mapView.delegate = context.coordinator
//        mapView.addOverlays(overlays)
//        return mapView
//    }
//    
//    func updateUIView(_ uiView: MKMapView, context: Context) {}
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator()
//    }
//    
//    class Coordinator: NSObject, MKMapViewDelegate {
//        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//            if let polygon = overlay as? MKPolygon {
//                let renderer = MKPolygonRenderer(polygon: polygon)
//                renderer.strokeColor = .blue
//                renderer.lineWidth = 1.0
//                return renderer
//            }
//            return MKOverlayRenderer()
//        }
//    }
//}
