//
//  KwanghyunView.swift
//  TEAM18
//
//  Created by 서광현 on 2022/11/23.
//

import SwiftUI
import MapKit

struct KwanghyunView: View {
    private let columns: [GridItem] = .init(repeating: .init(.flexible(), spacing: 16.0, alignment: .center), count: 2)
    
    @State private var coordinateRegion = MKCoordinateRegion(
        center: .init(latitude: 36.458351, longitude: 127.855843),
        span: .init(latitudeDelta: 4, longitudeDelta: 4)
    )
    @State private var place: IdentifiablePlace?
    
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
                    self.place = place
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
        .edgesIgnoringSafeArea(.all)
        .sheet(item: $place) {
            withAnimation(.easeOut) {
                coordinateRegion = MKCoordinateRegion(
                    center: .init(latitude: 36.458351, longitude: 127.855843),
                    span: .init(latitudeDelta: 4, longitudeDelta: 4)
                )
            }
        } content: { place in
            AirPollutionView(place: place.name)
        }
        
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        (lhs.latitude == rhs.latitude) && (lhs.longitude == rhs.longitude)
    }
}


struct AirPollutionView: View {
    @StateObject var dataStore: DataStoreAirPollution = DataStoreAirPollution(dataForm: [])
    private var webService: WebService = WebService()
    let place: String
    init(place: String) {
        self.place = place
    }
    var body: some View {
        ZStack {
            if dataStore.dataForm.isEmpty {
                ProgressView()
            } else {
                NavigationStack {
                    List {
                        ForEach(dataStore.dataForm) { air in
                            NavigationLink(value: air) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(air.stationName)
                                        .font(.headline)
                                    Text(air.dataTime ?? "(누락)")
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle(place)
                    .navigationDestination(for: AirQuality.self) { airQuality in
                        AirPollutionChartView(airQuality: airQuality)
                    }
                }
            }
        }
        .task {
            dataStore.dataForm = await webService.fetchData광현(url: URLS.광현님, sidoName: place)
        }
    }
}

struct AirPollutionChartView: View {
    let airQuality: AirQuality
    
    var body: some View {
            List {
                VStack(alignment: .leading) {
                    Text("일산화탄소")
                        .font(.headline)
                    Text("지수: " + (airQuality.coGrade ?? "(누락)"))
                    Text("농도: " + (airQuality.coValue ?? "(누락)") + " (단위: ppm)")
                    Text("\(airQuality.coValueDouble)")
                }
                .font(.subheadline)
                
                VStack(alignment: .leading) {
                    Text("이산화질소")
                        .font(.headline)

                    Text("지수: " + (airQuality.no2Grade ?? "(누락)"))
                    Text("농도: " + (airQuality.no2Value ?? "(누락)") + " (단위: ppm)")
                }
                .font(.subheadline)

                
                VStack(alignment: .leading) {
                    Text("아황산가스")
                        .font(.headline)

                    Text("지수: " + (airQuality.so2Grade ?? "(누락)"))
                    Text("농도: " + (airQuality.so2Value ?? "(누락)") + " (단위: ppm)")
                }
                .font(.subheadline)

                
                VStack(alignment: .leading) {
                    Text("오존")
                        .font(.headline)

                    Text("지수: " + (airQuality.o3Grade ?? "(누락)"))
                    Text("농도: " + (airQuality.o3Value ?? "(누락)") + " (단위: ppm)")
                }
                .font(.subheadline)

                
                VStack(alignment: .leading) {
                    Text("미세먼지(PM10) 24시간 등급자료")
                        .font(.headline)

                    Text("지수: " + (airQuality.pm10Grade ?? "(누락)"))
                    Text("농도: " + (airQuality.pm10Value ?? "(누락)") + " (단위: ㎍/㎥)")
                }
                .font(.subheadline)

                
                VStack(alignment: .leading) {
                    Text("미세먼지(PM25) 24시간 등급자료")
                        .font(.headline)

                    Text("지수: " + (airQuality.pm25Grade ?? "(누락)"))
                    Text("농도: " + (airQuality.pm25Value ?? "(누락)") + " (단위: ㎍/㎥)")
                }
                .font(.subheadline)

                
                VStack(alignment: .leading) {
                    Text("통합 대기환경 지수/농도")
                        .font(.headline)

                    Text("지수: " + (airQuality.khaiGrade ?? "(누락)"))
                    Text("농도: " + (airQuality.khaiValue ?? "(누락)"))
                }
                .font(.subheadline)

            } // LIST
            .navigationTitle(airQuality.sidoName+"시 "+airQuality.stationName+"의 공기질정보에요 🌬️")
            .navigationBarTitleDisplayMode(.inline)
    }
}

extension String? {
    func toDouble() -> Double? {
        if let value = self {
            return Double(value) ?? 0.0
        }
        return nil
    }
}

struct KwanghyunView_Previews: PreviewProvider {
    
    static var previews: some View {
        //            KwanghyunView()
        NavigationStack {
            AirPollutionChartView(airQuality: AirQuality.sample)
                .environment(\.locale, .init(identifier: "ko_KR"))
        }
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
