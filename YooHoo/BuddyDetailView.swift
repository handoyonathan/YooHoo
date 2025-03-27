//
//  BuddyDetailView.swift
//  YooHoo
//
//  Created by Salsabiila Bazaluna Febriadini on 26/03/25.
//

import SwiftUI

struct BuddyDetailView: View {
    let buddy: Buddy
    
    var body: some View {
        VStack(spacing: 4) {
            // Load gambar dari file system berdasarkan path
            if let imagePath = getImagePath(for: buddy.image),
               let uiImage = UIImage(contentsOfFile: imagePath.path) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 160, height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 140)
                    .foregroundColor(.gray)
                    .padding()
            }
            
            Text(buddy.name)
                .font(.title.bold())
                .foregroundColor(.indigo)
                .bold()
            
            Text(buddy.experience)
                .font(.body)
                .padding().multilineTextAlignment(.center)
            
            
            Spacer()
        }
        .padding()
        .presentationDetents([.medium, .medium])
        .presentationDragIndicator(.visible)
    }
    
    private func getImagePath(for fileName: String) -> URL? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsDirectory.appendingPathComponent(fileName)
    }
}

#Preview {
    BuddyDetailView(buddy: Buddy(name: "Yeha", image: "yeha", description: "I asked Amelia if she had a nickname, and she told me her family calls her ‘Mimi.’ It started when she was little, and it just stuck! It was fun learning a personal story behind her name."))
}
