//
//  QuestPage.swift
//  YooHoo
//
//  Created by Amelia Morencia Irena on 25/03/25.
//

import SwiftUI

struct teesss: View {
    var body: some View{
        
        VStack { 
            VStack(alignment: .leading) {
                Text("Siap berkenalan?")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                Text("Pilih tantangan, ajak ngobrol, dan tambah YooBuddy baru!")
                    .font(.subheadline)
                    .foregroundStyle(.black.opacity(0.7))
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)


            VStack {
                ZStack {
                    Image(.cardQuest)
                        .resizable()
                        .scaledToFit()

                    VStack {
                        Text("Topik Seru")
                            .font(.callout)
                            .foregroundStyle(.gray)
                        Text("Tanya seseorang tentang makna dari nama panggilannya")
                            .font(.headline)
                    }
                    .padding()
                }

                HStack(spacing: 12) {
                    Button(action: {}) {
                        Text("Acak Topik")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    Button(action: {}) {
                        Text("Ambil Tantangan")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.gray.opacity(0.05)) // Mewarnai background seluruh layar
    }
}

#Preview {
    teesss()
}
