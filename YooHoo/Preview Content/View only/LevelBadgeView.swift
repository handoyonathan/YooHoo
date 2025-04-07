import SwiftUI

enum BuddyLevel: Int, CaseIterable {
    case rookie = 0
    case explorer = 5
    case connector = 10
    case engager = 15
    case master = 30
    
    static var levelThresholds: [Int] {
        allCases.map { $0.rawValue }
    }
    
    var displayName: String {
        switch self {
        case .rookie: return "Rookie"
        case .explorer: return "Explorer"
        case .connector: return "Connector"
        case .engager: return "Engager"
        case .master: return "Master"
        }
    }
    
    static func nextLevel(from count: Int) -> BuddyLevel? {
        let sortedLevels = allCases.sorted { $0.rawValue < $1.rawValue }
        return sortedLevels.first { count < $0.rawValue }
    }
    
    static func currentLevel(for count: Int) -> BuddyLevel {
        let sortedLevels = allCases.sorted { $0.rawValue < $1.rawValue }
        var current = sortedLevels.first!
        for level in sortedLevels {
            if count >= level.rawValue {
                current = level
            } else {
                break
            }
        }
        return current
    }
}

struct LevelBadgeView: View {
    let buddyCount: Int
    let onBadgeTapped: (Int) -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(0..<BuddyLevel.levelThresholds.count, id: \.self) { index in
                let isUnlocked = buddyCount >= BuddyLevel.levelThresholds[index]
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
