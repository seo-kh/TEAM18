//
//  ContentView.swift
//  TEAM18
//
//  Created by 서광현 on 2022/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    HyeongiView()
                } label: {
                    Text("현기님")
                }
                
                NavigationLink {
                    SeongpilView()
                } label: {
                    Text("성필님")
                }
                
                NavigationLink {
                    HyeongguView()
                } label: {
                    Text("형구님")
                }
                
                NavigationLink {
                    KwanghyunView()
                } label: {
                    Text("광현님")
                }
            }
            .navigationTitle("18팀")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
