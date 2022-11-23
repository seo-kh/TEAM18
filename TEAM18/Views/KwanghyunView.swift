//
//  KwanghyunView.swift
//  TEAM18
//
//  Created by 서광현 on 2022/11/23.
//

import SwiftUI
import MapKit

struct KwanghyunView: View {
    @ObservedObject var dataStore: DataStoreAirPollution = DataStoreAirPollution(dataForm: [])
    
    private var webService: WebService = WebService()
    @State private var sido: [String] = ["서울","부산","대구","인천","광주","대전","울산","경기","강원","충북","충남","전북","전남","경북","경남","제주","세종"]
    private let columns: [GridItem] = .init(repeating: .init(.flexible(), spacing: 16.0, alignment: .center), count: 2)
    
    @State private var coordinateRegion = MKCoordinateRegion(
        center: .init(latitude: 36.458351, longitude: 127.855843),
        span: .init(latitudeDelta: 4, longitudeDelta: 4)
    )
    
    var body: some View {
        Map(
            coordinateRegion: $coordinateRegion,
            interactionModes: .all,
            showsUserLocation: false,
            userTrackingMode: .none,
            annotationItems: IdentifiablePlace.places
        ) {
                place in
                MapAnnotation(coordinate: place.location) {
                    Button {
                        withAnimation(.easeOut) {
                            coordinateRegion = MKCoordinateRegion(center: place.location, span: .init(latitudeDelta: 0.5, longitudeDelta: 0.5))
                        }
                    
                    } label: {
                        Text(place.name)
                            .font(.caption)
                            .fontWeight(.bold)
                            .shadow(radius: 8)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.pink)
                }
        }
        .overlay(alignment: .topLeading) {
            Button {
                withAnimation(.easeOut) {
                    coordinateRegion = MKCoordinateRegion(
                        center: .init(latitude: 36.458351, longitude: 127.855843),
                        span: .init(latitudeDelta: 4, longitudeDelta: 4)
                    )
                }
            } label: {
                Image(systemName: "chevron.left")
                    .frame(width: 40, height: 40)
                    .background(Material.thickMaterial)
                    .cornerRadius(20.0)
                    .padding()
            }

        }
    }
}

//Task {
//    dataStore.dataForm = try await webService.fetchData광현(url: URLS.광현님, sidoName: "부산")
//}

struct KwanghyunView_Previews: PreviewProvider {
    static var previews: some View {
//        NavigationStack {
//            KwanghyunView()
//        }
        
            KwanghyunView()
            .environment(\.locale, .init(identifier: "ko_KR"))
        
    }
}

struct IdentifiablePlace: Identifiable {
    let id: String
    let location: CLLocationCoordinate2D
    let name: String
    init(name: String, lat: Double, long: Double) {
        self.id = name
        self.name = name
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
    }
    static let places: [IdentifiablePlace] = [
        .init(name: "서울", lat: 37.564713, long: 126.975122),
        .init(name: "부산", lat: 35.180386, long: 129.074405),
        .init(name: "대구", lat: 35.890859, long: 128.599300),
        .init(name: "인천", lat: 37.454585, long: 126.707537),
        .init(name: "광주", lat: 35.159014, long: 126.853071),
        .init(name: "대전", lat: 36.350910, long: 127.383542),
        .init(name: "울산", lat: 35.538709, long: 129.310853),
        .init(name: "경기", lat: 37.361307, long: 127.437059),
        .init(name: "강원", lat: 37.905344, long: 128.159114),
        .init(name: "충북", lat: 36.840947, long: 127.679422),
        .init(name: "충남", lat: 36.396494, long: 126.897377),
        .init(name: "전북", lat: 35.754811, long: 127.178177),
        .init(name: "전남", lat: 35.069325, long: 127.289760),
        .init(name: "경북", lat: 36.473488, long: 128.825282),
        .init(name: "경남", lat: 35.377778, long: 128.027139),
        .init(name: "제주", lat: 33.499892, long: 126.530610),
        .init(name: "세종", lat: 36.482978, long: 127.261829),
    ]
}
//
//Map(coordinateRegion: $region,
//            annotationItems: [place]
//        ) { place in
//            MapAnnotation(coordinate: place.location) {
//                Rectangle().stroke(Color.blue)
//                .frame(width: 20, height: 20)
//            }
//        }

