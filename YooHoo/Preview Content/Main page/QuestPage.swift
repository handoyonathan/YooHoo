import SwiftUI
import SwiftData

struct QuestPage: View {
    @State private var showExperienceForm = false
    @State private var selectedBadgeIndex: Int? = nil
    @State private var showBadgePopup = false
    @Environment(\.modelContext) var modelContext
    @Query private var buddies: [Buddy]
    @StateObject private var questManager = QuestManager()
    
    var currentLevel: BuddyLevel {
        BuddyLevel.currentLevel(for: buddies.count)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 32){
                    headerSection
//                    questCardSection
                    progressSection
                    infoSection
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .background(Color.gray.opacity(0.05))
            .sheet(isPresented: $showExperienceForm) {
                NavigationView {
                    ExperienceFormView()
                }
            }
            .overlay(BadgePopupView())
        }
    }

    // MARK: - View Sections

    var headerSection: some View {
        VStack (spacing: 12){
            VStack(alignment: .leading, spacing: 8) {
                Text("Tantangan Harian")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                Text("Kenalan kuy")
                    .font(.title)
                    .fontWeight(.semibold)
//                                .padding(.bottom, 4)
                Text("Pilih tantangan, ajak ngobrol, dan tambah teman baru!")
                    .font(.subheadline)
//                    .padding(.bottom, 16)
                    .foregroundStyle(.black.opacity(0.7))
            }
            .padding(.top, 16)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack (spacing: 16){
                VStack {
                    Text(questManager.currentQuest)
                        .font(.body)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .frame(maxWidth: .infinity, idealHeight: 120)
                .background(Color.indigo.opacity(0.05))
                .cornerRadius(12)
                .padding(.horizontal)
//                .padding(.bottom, 8)
                
                
                HStack(spacing: 12){
                    Button(action: { questManager.shuffleQuest() }) {
                        HStack {
                            Image(systemName: "shuffle")
                            Text("acak topik")
                                .font(.callout)
                        }
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(.indigo)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(12)
                    }
                    
                    Button(action: {
                        showExperienceForm = true
                    }) {
                        HStack {
                            Image(systemName: "eyeglasses")
                            Text("ambil tantangan")
                                .font(.callout)
                        }
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(Color.indigo)
                        .cornerRadius(12)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
            }
        }
        
        }
        

//    var questCardSection: some View {
//        
//    }

    var progressSection: some View {
        VStack (spacing : 8){
            Text("Progressku")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)

            VStack(spacing: 8) {
                LevelBadgeView(buddyCount: buddies.count) { index in
                    selectedBadgeIndex = index
                    showBadgePopup = true
                }
//                .padding(.bottom, 8)

                Text(levelGreetingText)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Text("\(buddies.count) Teman")
                    .font(.title)
                    .foregroundStyle(.indigo)
                    .fontWeight(.bold)

                Text(levelProgressText)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 24)
            .background(Color.white)
            .cornerRadius(12)
            .frame(maxWidth: .infinity)
        }
        
//        .padding(.horizontal, 16)
    }

    var infoSection: some View {
        VStack (spacing: 8) {
            Text("Benefits YooHoo?")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)

            HStack {
                VStack(spacing: 8) {
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

                VStack(spacing: 8) {
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
    }

    // MARK: - Computed Texts

    var levelGreetingText: String {
        return "Hai \(currentLevel.displayName)! Saat ini kamu udah punya.."
        
    }

    var levelProgressText: String {
        if let nextLevel = BuddyLevel.nextLevel(from: buddies.count) {
            return "Cari \(nextLevel.rawValue - buddies.count) teman lagi untuk naik ke level \(nextLevel.displayName) 🎉"
        } else {
            return "Bareng YooHoo, kamu menaklukkan puncak pertemanan! 🎉"
        }
    }

    // MARK: - Badge Popup View

    @ViewBuilder
    private func BadgePopupView() -> some View {
        if showBadgePopup, let index = selectedBadgeIndex {
            let isUnlocked = buddies.count >= BuddyLevel.levelThresholds[index]
            let imageName = isUnlocked ? "Level \(index + 1)" : "Unlocked \(index + 1)"

            ZStack {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showBadgePopup = false
                    }

                VStack {
                    Spacer()
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 300)
                        .onTapGesture {
                            showBadgePopup = false
                        }
                    Spacer()
                }
            }
            .transition(.opacity)
        }
    }
}

#Preview {
    QuestPage().modelContainer(for: [Buddy.self], inMemory: false)
}
