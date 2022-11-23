//
//  KwanghyunView.swift
//  TEAM18
//
//  Created by 서광현 on 2022/11/23.
//

import SwiftUI

struct KwanghyunView: View {
    @ObservedObject var dataStore: DataStoreAirPollution = DataStoreAirPollution(dataForm: [])
    
    var webService: WebService = WebService()
    
    var body: some View {
        VStack {
            Button("Fetch Data") {
                Task {
                    dataStore.dataForm = try await webService.fetchData광현(url: URLS.광현님)
                }
            }
            List {
                ForEach(dataStore.dataForm) { data in
                    VStack(alignment: .leading) {
                        Text(data.sidoName)
                            .font(.headline)
                        Text(data.stationName)
                            .font(.subheadline)
                        Text(data.dataTime ?? "(누락)")
                            .font(.caption)
                    }
                }
            }
        }
    }
}


struct KwanghyunView_Previews: PreviewProvider {
    static var previews: some View {
        KwanghyunView()
    }
}
