//
//  BuddyListView.swift
//  YooHoo
//
//  Created by Salsabiila Bazaluna Febriadini on 26/03/25.
//

import SwiftUI
import SwiftData

struct BuddyListView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var buddies: [Buddy]
    
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
                        Button(action: { showDetail = true }) {
                            //                            VStack(spacing: 4) {
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.indigo)
                            //                                Text("Tambah YooBuddy")
                            //                                    .font(.caption)
                            //                                    .foregroundColor(.gray)
                            //                            }
                                .frame(width: 174, height: 222)
                                .background(Color.white)
                                .cornerRadius(20)
                        }
                        
                        ForEach(buddies) { buddy in
                            BuddyCardView(buddy: buddy) {
                                selectedBuddy = buddy
                            }
                        }
                    }
                    .padding()
                }
            }
            .background(Color.gray.opacity(0.1))
            .sheet(isPresented: $showdetail) {
                NavigationView {
                    ExperienceFormView()
                }
            }
            .sheet(item: $selectedBuddy) { buddy in
                BuddyDetailView(buddy: buddy)
            }
        }
    }
}

#Preview {
    BuddyListView()
        .modelContainer(for: [Buddy.self], inMemory: false)
}
