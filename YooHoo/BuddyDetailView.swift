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
            Image(buddy.image)
                .resizable()
                .scaledToFit()
                .frame(height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding()

            Text(buddy.name)
                .font(.title.bold())
                .foregroundColor(.indigo)
                .bold()

            Text(buddy.description)
                .font(.body)
                .padding()

            Spacer()
        }
        .padding()
        .presentationDetents([.medium, .medium])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    BuddyDetailView(buddy: Buddy(name: "Yeha", image: "yeha", description: "I asked Amelia if she had a nickname, and she told me her family calls her ‘Mimi.’ It started when she was little, and it just stuck! It was fun learning a personal story behind her name. I asked Amelia if she had a nickname, and she told me her family calls her ‘Mimi.’ It started when she was little, and it just stuck! It was fun learning a personal story behind her name. I asked Amelia if she had a nickname, and she told me her family calls her ‘Mimi.’"))
}
