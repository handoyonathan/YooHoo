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
                Text("Tantangan")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                Text("Mulai Kenalan")
                    .font(.title)
                    .fontWeight(.semibold)
                //                                .padding(.bottom, 4)
                Text("Pilih topik, ajak ngobrol, dan tambah teman baru!")
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
                .background(Color.white)
                .cornerRadius(12)
                .padding(.horizontal)
                //                .padding(.bottom, 8)
                
                
                HStack(spacing: 12){
                    Button(action: { questManager.shuffleQuest() }) {
                        HStack {
                            Image(systemName: "shuffle")
                            Text("Acak topik")
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
                            Image(systemName: "pencil.line")
                            Text("Tulis pengalaman")
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
                
                Text("Hai ")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                + Text(currentLevel.displayName)
                    .font(.subheadline)
                    .fontWeight(.black)
                    .foregroundStyle(.gray)
                + Text("! ")
                    .font(.subheadline)
                    .fontWeight(.black)
                    .foregroundStyle(.gray)
                + Text("Saat ini kamu punya ")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
                Text("\(buddies.count) Teman")
                    .font(.title)
                    .foregroundStyle(.indigo)
                    .fontWeight(.bold)
                
                //                Text(levelProgressText)
                //                    .font(.subheadline)
                //                    .foregroundColor(.gray)
                
                if let nextLevel = BuddyLevel.nextLevel(from: buddies.count) {
                    Text("Cari ")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    + Text("\(nextLevel.rawValue - buddies.count) teman")
                        .font(.subheadline)
                        .fontWeight(.black)
                        .foregroundColor(.gray)
                    + Text(" lagi untuk naik ke level ")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    + Text(nextLevel.displayName)
                        .font(.subheadline)
                        .fontWeight(.black)
                        .foregroundColor(.gray)
                } else {
                    Text("Bareng YooHoo, kamu menaklukkan puncak pertemanan!")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
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
        VStack (alignment: .leading, spacing: 8){
            Text("Tentang YooHoo")
                .font(.title)
                .fontWeight(.semibold)
//                .frame(alignment: .leading)
                .padding(.horizontal, 16)
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.white)
                    .frame(idealWidth: .infinity)
                    .cornerRadius(20)
                
                HStack(spacing: 0) {
                    Image("Binder")
                        .resizable()
                        .frame(width: 50, height: 240)
                        .padding(.leading, -25)
                    
                    VStack (spacing: 16){
                        VStack (alignment: .leading, spacing: 8){
                            Text("Tantangan Seru 🎁")
                                .fontWeight(.semibold)
                            Text("Pilih tantangan seru dan mulai ngobrol tanpa bingung cari topik.")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        }
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 8){
                            Text("Catat Momen 📝")
                                .fontWeight(.semibold)
                            Text("Simpan nama temamnmu, selfie, dan obrolan biar momen gak terlupa.")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        }
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 8){
                            Text("Tambah Teman, Naik Level! 🎉")
                                .fontWeight(.semibold)
                            Text("Tambah Teman, naik level, dan jadilah Master YooHoo!")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        }
                        
                        
                        
                    }
                    .padding()
                        .padding(.vertical, 16)
                    
                }
            }
            .padding(.horizontal)
            .padding(.leading, 24)

            
        }
        .padding(.bottom, 8)
        
    }
    
    // MARK: - Computed Texts
    
    //    var levelProgressText: String {
    //        if let nextLevel = BuddyLevel.nextLevel(from: buddies.count) {
    //            return "Cari \(nextLevel.rawValue - buddies.count) teman lagi untuk naik ke level \(nextLevel.displayName) 🎉"
    //        } else {
    //            return "Bareng YooHoo, kamu menaklukkan puncak pertemanan! 🎉"
    //        }
    //    }
    
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
