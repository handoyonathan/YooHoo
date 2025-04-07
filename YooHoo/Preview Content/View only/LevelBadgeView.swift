import SwiftUI

struct LevelBadgeView: View {
    let buddyCount: Int
    let onBadgeTapped: (Int) -> Void
    private let levelThresholds = [0, 5, 10, 15, 30]
    
    var body: some View {
            HStack(spacing: 12) {
                ForEach(0..<5, id: \.self) { index in
                    let isUnlocked = buddyCount >= levelThresholds[index]
                    Image(isUnlocked ? "Level \(index + 1)" : "Unlocked \(index + 1)")
                        .resizable()
                        .frame(width: 60, height: 70)
                        .scaledToFit()
                        .onTapGesture {
                            onBadgeTapped(index)
                }
                    
            }
        }
    }
}
