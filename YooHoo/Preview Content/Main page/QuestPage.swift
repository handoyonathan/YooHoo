import SwiftUI
import SwiftData

struct QuestPage: View {
    @State private var showExperienceForm = false
    @Environment(\.modelContext) var modelContext
    @Query private var buddies: [Buddy]
    @StateObject private var questManager = QuestManager()
    
    var body: some View {
        let currentLevel = BuddyLevel.currentLevel(for: buddies.count)
        NavigationStack {
            ScrollView {
                VStack {
                    VStack(alignment: .leading) {
                        Text("Siap berkenalan?")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom, 8)
                        Text("Pilih tantangan, ajak ngobrol, dan tambah teman baru!")
                            .font(.body)
                        
                            .foregroundStyle(.black.opacity(0.7))
                    }
                    .padding(.top, 16)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack {
                        ZStack {
                            Image(.cardQuest)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity)
                                .clipped()
                            VStack {
                                Text(questManager.currentQuest)
                                    .font(.callout)
                                    .fontWeight(.medium)
                                    .multilineTextAlignment(.center)
                                    .padding()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .frame(maxWidth: .infinity)
                        .cornerRadius(12)
                        .padding(.horizontal, 16)
                        HStack(spacing: 12){
                            Button(action: {questManager.shuffleQuest()}) {
                                HStack{
                                    Image(systemName: "shuffle")
                                    Text("Acak Topik")
                                        .font(.callout)
                                }
                                .font(.headline)
                                .fontWeight(.regular)
                                .foregroundColor(.indigo)
                                .padding(.vertical, 14)
                                .frame(maxWidth:.infinity)
                                .background(Color.white)
                                .cornerRadius(12)
                            }
                            
                            Button(action: {
                                showExperienceForm = true
                            }) {
                                HStack {
                                    Image(systemName: "eyeglasses")
                                    Text("Ambil Tantangan")
                                        .font(.callout)
                                }
                                .font(.headline)
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                                .padding(.vertical, 14)
                                .frame(maxWidth:.infinity)
                                .background(Color.indigo)
                                .cornerRadius(12)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                    }
                    
                    VStack {
                        Text("Progressku")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 16)
                    }
                    
                    VStack(spacing: 4) {
                        HStack {
                            LevelBadgeView(buddyCount: buddies.count)
                        }
                        .padding(.bottom, 4)
                        if currentLevel == .master || buddies.count >= 50 {
                            Text("Hai \(currentLevel.displayName)! Saat ini kamu udah punya..")
                                .font(.caption)
                                .foregroundColor(.gray)
                        } else {
                            Text("Hai \(currentLevel.displayName)! Perjalananmu masih seru, yuk tambah teman lagi!")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Text("\(buddies.count) Teman")
                            .font(.title)
                            .foregroundStyle(.indigo)
                            .fontWeight(.bold)
                        if let nextLevel = BuddyLevel.nextLevel(from: buddies.count) {
                            Text("Cari \(nextLevel.rawValue - buddies.count) teman lagi untuk naik ke level \(nextLevel.displayName) 🎉")
                                .font(.caption)
                                .foregroundColor(.gray)
                        } else {
                            Text("Bareng YooHoo, kamu menaklukkan puncak pertemanan! 🎉")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .background(Color.white)
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity)
                    
                    VStack {
                        Text("Ada apa di YooHoo?")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 16)
                    }
                    
                    HStack {
                        VStack(spacing: 6) {
                            Image("Tantangan")
                                .resizable()
                                .frame(width: 64, height: 64)
                                .scaledToFit()
                            Text("Terima Tantangan")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundStyle(.indigo)
                            Text("Temui teman baru, abadikan momen berkenalan, dan tulis pengalamanmu!")
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.gray)
                                .font(.caption)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white)
                        .cornerRadius(12)
                        
                        VStack(spacing: 6){
                            Image("List YooBuddy")
                                .resizable()
                                .frame(width: 64, height: 64)
                                .scaledToFit()
                            Text("Lihat Teman")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundStyle(.indigo)
                            Text("Lihat kembali siapa saja yang sudah kamu temui dan kenali mereka lebih dalam.")
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.gray)
                                .font(.caption)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal, 16)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .background(Color.gray.opacity(0.05))
            .sheet(isPresented: $showExperienceForm) {
                NavigationView {
                    ExperienceFormView()
                }
            }
        }
    }
}

#Preview {
    QuestPage().modelContainer(for: [Buddy.self], inMemory: false)
}
