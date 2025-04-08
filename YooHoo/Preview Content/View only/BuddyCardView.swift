//
//  BuddyCardView.swift
//  YooHoo
//
//  Created by Salsabiila Bazaluna Febriadini on 26/03/25.
//

import SwiftUI

struct BuddyCardView: View {
    let buddy: Buddy
    
    var body: some View {
        VStack(spacing: 4) {
            if let imagePath = getImagePath(for: buddy.image),
               let uiImage = UIImage(contentsOfFile: imagePath.path) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 160, maxHeight: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 160, maxHeight: 160)
                    .foregroundColor(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            Text(buddy.name)
                .font(.headline.bold())
                .foregroundColor(.indigo)
            
            Text(buddy.experience)
                .font(.caption)
                .foregroundColor(.gray)
                .frame(maxWidth: 158, maxHeight: 16)
        }
        .frame(width: 174, height: 222)
        .background(Color.white)
        .cornerRadius(20)
    }
    
    private func getImagePath(for fileName: String) -> URL? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsDirectory.appendingPathComponent(fileName)
    }
}

//#Preview {
//    BuddyCardView(buddy: Buddy(name: "Mimi", image: "mimi", description: "Teman yang asik!"))
//        .previewLayout(.sizeThatFits)
//}
