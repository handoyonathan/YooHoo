//
//  MainTabView.swift
//  YooHoo
//
//  Created by Amelia Morencia Irena on 26/03/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView{
            QuestPage()
                .tabItem{
                    Image(systemName: "gift")
                    Text("Tantangan Harian")
                    
                }
            teesss() //ini ganti ke page yang luna buat
                .tabItem{
                    Image(systemName: "person.3")
                    Text("List YooBuddy")
                }
        }
        .background(Color.white)
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    MainTabView()
}
