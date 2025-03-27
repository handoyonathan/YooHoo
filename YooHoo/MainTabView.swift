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
                    Label("Tantangan Harian", systemImage: "gift")
                    
                }
            BuddyListView()
                .tabItem{
                    Label("List YooBuddy", systemImage: "person.3")
                    
                }
        }
        .background(Color.white)
        .tint(Color.indigo)
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    MainTabView()
}
