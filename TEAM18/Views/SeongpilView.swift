//
//  SeongpilView.swift
//  TEAM18
//
//  Created by 서광현 on 2022/11/23.
//

import SwiftUI

struct SeongpilView: View {
    @ObservedObject var dataStore: DataStoreRestaurant = DataStoreRestaurant(dataForm: [])
    
    var webService: WebService = WebService()
    
    var body: some View {
        VStack {
            Button("Fetch Data") {
                Task {
                    dataStore.dataForm = try await webService.fetchData성필(url: URLS.성필님)
                }
            }
            List {
                ForEach(dataStore.dataForm, id: \.bzNm) { data in
                    Text("\(data.smplDesc)")
                        .font(.headline)
                }
            }
        }
    }
}


struct SeongpilView_Previews: PreviewProvider {
    static var previews: some View {
        SeongpilView()
    }
}
