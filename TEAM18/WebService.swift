//
//  WebService.swift
//  TEAM18
//
//  Created by 서광현 on 2022/11/23.
//

import Foundation

class WebService {
    
    // 동시에 쓰여야할땐 async 써야한다?
    func fetchData현기(url: String) async throws -> [DataForm] {
        guard let url = URL(string: url) else { return [] }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let prices = try JSONDecoder().decode(PriceDataForm.self, from: data)
        
        for i in prices.DATA {
            print("\(i.n_title)")
        }
        
        return prices.DATA
    }

    // 동시에 쓰여야할땐 async 써야한다?
    func fetchData성필(url: String) async throws -> [Restaurant] {
        guard let url = URL(string: url) else { return [] }

        let (data, _) = try await URLSession.shared.data(from: url)
        let resturant = try JSONDecoder().decode(RestaurantDataModel.self, from: data)

        
        return resturant.data
    }

    // 동시에 쓰여야할땐 async 써야한다?
    func fetchData형구(url: String) async throws -> [Bicycle] {
        guard let url = URL(string: url) else { return [] }

        let (data, _) = try await URLSession.shared.data(from: url)
        let bicycles = try JSONDecoder().decode([Bicycle].self, from: data)

        
        return bicycles
    }

    // 동시에 쓰여야할땐 async 써야한다?
    func fetchData광현(url: String, sidoName: String = "서울") async -> [AirQuality] {
        let urlString = url + "&sidoName=" + (sidoName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        guard let url = URL(string: urlString) else {
            print("error")
            return []
            
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let airs = try JSONDecoder().decode(AirPollutionInformation.self, from: data)
            return airs.items
        } catch {
            print("error")
        }
        return []
    }
}
