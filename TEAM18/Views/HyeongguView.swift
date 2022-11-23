//
//  HyeongguView.swift
//  TEAM18
//
//  Created by 서광현 on 2022/11/23.
//

import SwiftUI

struct HyeongguView: View {
    @ObservedObject var dataStore: DataStoreBicycle = DataStoreBicycle(dataForm: [])
    var webService: WebService = WebService()

    var body: some View {
        NavigationStack {
            VStack {
                List{
                    ForEach(dataStore.dataForm, id: \.id) { data in
                        NavigationLink(destination: BicycleMapView(), label: {
                            Text("\(data.statn_addr1)")
                                .font(.headline)
    
                        })
                    }
                }
            }.onAppear {
                Task {
                    dataStore.dataForm = try await webService.fetchData형구(url: URLS.형구님)
                }
            }
        }.navigationTitle("따릉이 대여소")
    }
}


struct HyeongguView_Previews: PreviewProvider {
    static var previews: some View {
        HyeongguView()
    }
}
