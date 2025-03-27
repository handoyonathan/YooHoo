import SwiftUI

struct LevelBadgeView: View {
    let buddyCount: Int
    
    private let levelThresholds = [0, 6, 11, 16, 31]

    var body: some View {
        HStack {
            ForEach(0..<5, id: \.self) { index in
                if buddyCount >= levelThresholds[index] {
                    Image("Level \(index + 1)")
                        .resizable()
                        .frame(width: 60, height: 70)
                        .scaledToFit()
                } else {
                    Image("Unlocked")
                        .resizable()
                        .frame(width: 60, height: 70)
                        .scaledToFit()
                }
            }
        }
    }
}
