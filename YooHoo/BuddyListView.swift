//
//  BuddyListView.swift
//  YooHoo
//
//  Created by Salsabiila Bazaluna Febriadini on 26/03/25.
//


import SwiftUI

struct BuddyListView: View {
    
    let buddies = [
        Buddy(name: "Mimi", image: "mimi", description: "I asked Amelia if she had a nickname, and she told me her family calls her ‘Mimi.’ It started when she was little, and it just stuck! It was fun learning a personal story behind her name."),
        Buddy(name: "Yeha", image: "yeha", description: "I asked Amelia if she had a nickname, and she told me her family calls her ‘Mimi.’ It started when she was little, and it just stuck! It was fun learning a personal story behind her name"),
        Buddy(name: "Luna", image: "luna", description: "I asked Amelia if she had a nickname, and she told me her family calls her ‘Mimi.’ It started when she was little, and it just stuck! It was fun learning a personal story behind her name")
    ]

    @State private var selectedBuddy: Buddy?
    @State private var showDetail = false

    let columns = [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 0)]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 8) {
                Text("List YooBuddy")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                Text("Jelajahi kembali momen seru dengan YooBuddy yang pernah kamu temui!")
                    .font(.body)
                    .foregroundColor(.black.opacity(0.6))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 12) {
                        // Tombol tambah YooBuddy
                        Button(action: {
                            print("Tambah YooBuddy")
                        }) {
                            VStack (spacing: 4){
                                Image(systemName: "plus")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.indigo)
                                Text("Tambah YooBuddy")
                                    .font(.caption)
                                    .foregroundColor(.gray)

                                
                            }
                            .frame(width: 174, height: 222)
                            .background(Color.white)
                            .cornerRadius(20)
                        }

                        // Daftar Buddy
                        ForEach(buddies) { buddy in
                            BuddyCardView(buddy: buddy) {
                                selectedBuddy = buddy
                                showDetail.toggle()
                            }
                        }
                    }
                    .padding()
                }
            }
            .background(Color.gray.opacity(0.05))
            .sheet(item: $selectedBuddy) { buddy in
                BuddyDetailView(buddy: buddy)
            }
        }
    }
}

#Preview {
    BuddyListView()
}
