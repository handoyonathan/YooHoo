//
//  BuddyCardView.swift
//  YooHoo
//
//  Created by Salsabiila Bazaluna Febriadini on 26/03/25.
//

import SwiftUI

struct BuddyCardView: View {
    let buddy: Buddy
    var onTap: () -> Void

    var body: some View {
        VStack(spacing: 4){
            Image(buddy.image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 160, maxHeight: 160)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Text(buddy.name)
                .font(.headline.bold())
                .foregroundColor(.indigo)
            
            Text("Sneak-peek perkenalan sa..")
                .font(.caption)
                .foregroundColor(.gray)
                .frame(maxWidth: 158, maxHeight: 16)
        }
        .frame(maxWidth: 174, maxHeight: 222)
        .padding(8)
        .background(Color.white)
        .cornerRadius(20)
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    BuddyCardView(buddy: Buddy(name: "Mimi", image: "mimi", description: "Teman yang asik!"), onTap: {})
        .previewLayout(.sizeThatFits)
}
