//
//  HyeongiView.swift
//  TEAM18
//
//  Created by 서광현 on 2022/11/23.
//

import SwiftUI

struct HyeongiView: View {
    @ObservedObject var dataStore: DataStore = DataStore(dataForm: [])
    
    var webService: WebService = WebService()
    
    var body: some View {
        VStack {
            Button("Fetch Data") {
                Task {
                    dataStore.dataForm = try await webService.fetchData현기(url: URLS.현기님)
                }
            }
            List {
                ForEach(dataStore.dataForm, id: \.n_title) { data in
                    Text("\(data.n_title)")
                        .font(.headline)
                }
            }
        }
    }
}

struct HyeongiView_Previews: PreviewProvider {
    static var previews: some View {
        HyeongiView()
    }
}
