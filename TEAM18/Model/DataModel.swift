//
//  DataModel.swift
//  TEAM18
//
//  Created by 서광현 on 2022/11/23.
//

import Foundation
import SwiftUI
import CoreLocation
// MARK: - 현기님
struct PriceDataForm: Codable {
    var DESCRIPTION: Description
    var DATA: [DataForm]
}

struct Description: Codable {
    var N_SEQ: String           // 일련번호
    var N_TITLE: String         // 제목
    var REG_DATE: String        // 등록일
    var N_VIEW_COUNT: String    // 조회수
    var FILE_PATH: String       // 첨부파일경로
    var N_CONTENTS: String      // 내용
}

struct DataForm: Codable {
    var n_seq: Int              // 일련번호
    var n_title: String         // 제목
    var reg_date: Int           // 등록일
    var n_view_count: Int       // 조회수
    var file_path: String?      // 첨부파일경로
    var n_contents: String      // 내용
}

class DataStore: ObservableObject {
    
    @Published var dataForm: [DataForm]
    
    init(dataForm: [DataForm] = []) {
        self.dataForm = dataForm
    }
}

// MARK: - 형구님
struct Bicycle : Codable, Identifiable{
    var id: String {
        get {
            return lendplace_id
        }
    }
    var lendplace_id: String
    var statn_addr1: String
    var statn_addr2: String
    var statn_lat: Double
    var statn_lnt: Double
}

class DataStoreBicycle: ObservableObject {
    
    @Published var dataForm: [Bicycle]
    
    init(dataForm: [Bicycle] = []) {
        self.dataForm = dataForm
    }
}


// MARK: - 성필님
struct RestaurantDataModel: Codable {
    let data: [Restaurant]
}

struct Restaurant: Codable {
    let gngCS: String // 위치
    let fdCS: String // 음식 종류
    let bzNm: String // 가게 이름
    let smplDesc: String // 설명
    
    enum CodingKeys: String, CodingKey {
        case gngCS = "GNG_CS"
        case fdCS = "FD_CS"
        case bzNm = "BZ_NM"
        case smplDesc = "SMPL_DESC"
    }
}

class DataStoreRestaurant: ObservableObject {
    
    @Published var dataForm: [Restaurant]
    
    init(dataForm: [Restaurant] = []) {
        self.dataForm = dataForm
    }
}


// MARK: - 광현님
struct AirPollutionInformation: Codable {
    private let response: Body
    var items: [AirQuality] { response.body.items }
    
    struct Body: Codable {
        let body: Items
    }
    
    struct Items: Codable {
        let items: [AirQuality]
    }
}

struct AirQuality: Codable, Identifiable, Hashable {
    
    var id: String { return stationName }
    // 시
    let sidoName: String
    // 측정장소
    let stationName: String
    // 시간대
    let dataTime: String?
    
    // 통합 대기환경 지수/농도
    let khaiGrade: String?
    let khaiValue: String?
    // 아황산가스 지수/농도
    let so2Grade: String?
    let so2Value: String?
    // 일산화탄소 지수/농도
    let coGrade: String?
    let coValue: String?
    // 오존 지수/농도
    let o3Grade: String?
    let o3Value: String?
    // 이산화질소 지수/농도
    let no2Grade: String?
    let no2Value: String?
    
    // 미세먼지(PM10) 24시간 등급자료/농도
    let pm10Grade: String?
    let pm10Value: String?
    // 미세먼지(PM25) 24시간 등급자료/농도
    let pm25Grade: String?
    let pm25Value: String?
    
    static let sample = AirQuality(
        sidoName: "서울", stationName: "중구", dataTime: "2022-11-23 16:00", khaiGrade: "2", khaiValue: "69", so2Grade: "1", so2Value: "0.003", coGrade: "1", coValue: "0.4", o3Grade: "2", o3Value: "0.041", no2Grade: "1", no2Value: "0.010", pm10Grade: "2", pm10Value: "23", pm25Grade: "2", pm25Value: "17")
}

class DataStoreAirPollution: ObservableObject {
    
    @Published var dataForm: [AirQuality]
    
    init(dataForm: [AirQuality] = []) {
        self.dataForm = dataForm
    }
}
