//
//  BicycleMapView.swift
//  TEAM18
//
//  Created by 조형구 on 2022/11/23.
//

import SwiftUI
import MapKit

struct AnnotatedItem: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}
var pointsOfInterest = [
    AnnotatedItem(name: "asfas", coordinate: .init(latitude: 37.53439, longitude: 126.869598))
  
]
struct BicycleMapView: View {
    @ObservedObject var dataStore: DataStoreBicycle = DataStoreBicycle(dataForm: [])
    var webService: WebService = WebService()
    
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.53439, longitude: 126.869598),
            span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
        )
    
    var body: some View {
        NavigationStack {
            VStack {
                Map(coordinateRegion: $region,
                    annotationItems: pointsOfInterest) { item in
                    MapMarker(coordinate: item.coordinate, tint: .purple)
                }
            }
            .navigationTitle("Map")
        }.onAppear {
            Task {
                dataStore.dataForm = try await webService.fetchData형구(url: URLS.형구님)
            }
        }
    }
}


struct BicycleMapView_Previews: PreviewProvider {
    static var previews: some View {
        BicycleMapView()
    }
}
