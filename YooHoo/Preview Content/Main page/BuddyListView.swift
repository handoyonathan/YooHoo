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
    @Query(sort: \Buddy.name, order: .forward) private var buddies: [Buddy]
    
    @State private var showDetail = false
    @State private var selectedFilter = FriendFilter.AZ
    
    let columns = [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 0)]
    
    private var filteredBuddies: [Buddy] {
        switch selectedFilter {
        case .AZ:
            return buddies.sorted { $0.name.lowercased() < $1.name.lowercased() }
        case .ZA:
            return buddies.sorted { $0.name.lowercased() > $1.name.lowercased() }
        case .latest:
            return buddies.sorted { $0.createdAt > $1.createdAt }
        case .oldest:
            return buddies.sorted { $0.createdAt < $1.createdAt }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Daftar Teman")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Menu {
                        Picker("Filter", selection: $selectedFilter) {
                            ForEach(FriendFilter.allFilter, id: \.self) { filter in
                                Text(filter.rawValue)
                            }
                        }
                        .pickerStyle(.inline)
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.title)
                            .padding(.horizontal)
                    }
                }
                
                Text("Jelajahi kembali momen seru dengan Teman yang pernah kamu temui!")
                    .font(.subheadline)
                    .foregroundStyle(.black.opacity(0.7))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.trailing, 60)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 12) {
                        Button(action: { showDetail = true }) {
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.indigo)
                                .frame(width: 174, height: 222)
                                .background(Color.white)
                                .cornerRadius(20)
                        }
                        
                        ForEach(filteredBuddies) { buddy in
                            NavigationLink(destination: BuddyDetailView(buddy: buddy)) {
                                BuddyCardView(buddy: buddy)
                            }
                        }
                    }
                    .padding()
                }
            }
//            .navigationTitle("Daftar Teman")
            .padding(.top, 16)
            .background(Color.gray.opacity(0.05))
            .sheet(isPresented: $showDetail) {
                NavigationView {
                    ExperienceFormView()
                }
            }
        }
    }
}

//#Preview {
//    BuddyListView()
//        .modelContainer(for: [Buddy.self], inMemory: false)
//}
