//
//  QuestPage.swift
//  YooHoo
//
//  Created by Amelia Morencia Irena on 25/03/25.
//

import SwiftUI

struct QuestPage: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    VStack(alignment: .leading) {
                        Text("Siap berkenalan?")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom, 8)
                        Text("Pilih tantangan, ajak ngobrol, dan tambah YooBuddy baru!")
                            .font(.subheadline)
                            .foregroundStyle(.black.opacity(0.7))
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack{
                        ZStack{
                            Image(.cardQuest)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity)
                                .clipped()
                            //                        .padding(.horizontal)
                            VStack{
                                Text("Topik Seru")
                                    .font(.callout)
                                    .foregroundStyle(.gray)
                                //                            .padding(.bottom,16)
                                
                                Text("Tanya seseorang tentang makna dari nama panggilannya")
                                    .font(.callout)
                                    .fontWeight(.medium)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                
                            }
                            
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                        }
                        .frame(maxWidth: .infinity)
                        .cornerRadius(12)
                        .padding(.horizontal, 16)
                        
                        HStack(spacing: 12){
                            Button(action: {}) {
                                HStack{
                                    Image(systemName: "shuffle")
                                    Text("Acak Topik")
                                        .font(.callout)
                                }
                                .font(.headline)
                                .fontWeight(.regular)
                                .foregroundColor(.indigo)
                                .padding(.vertical, 20)
                                .frame(maxWidth:.infinity)
                                .background(Color.white)
                                .cornerRadius(12)
                            }
                            
                            Button(action: {}) {
                                HStack{
                                    Image(systemName: "eyeglasses")
                                    Text("Ambil Tantangan")
                                        .font(.callout)
                                }
                                
                                .font(.headline)
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                                .padding(.vertical, 20)
                                .frame(maxWidth:.infinity)
                                .background(Color.indigo)
                                .cornerRadius(12)
                            }
                            
                        }
                        .frame(maxWidth: .infinity) // Supaya HStack mengambil seluruh lebar
                        .padding(.horizontal, 16)
                    }
                    //                        .padding()
                    VStack(){
                        Text("Progressku")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 16)
                        
                    }
                    VStack(spacing: 4){
                        
                        HStack(){
                            Image("Level 1")
                            Image("Level 2")
                            Image("Level 3")
                            Image("Level 4")
                            Image("Level 5")
                        }
                        .padding(.bottom, 4)
                        Text("Mulai ngobrol dan temukan teman baru")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("0 YooBuddy")
                            .font(.title)
                            .foregroundStyle(.indigo)
                            .fontWeight(.bold)
                        
                        Text("Ambil tantangan pertama kamu sekarang!")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                    }
                    
                    .padding(.horizontal, 32)
                    .padding(.vertical, 16)
                    .background(Color.white)
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity)
                    
                    VStack{
                        Text("Ada apa di YooHoo?")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 16)
                        
                    }
                    
                    HStack{
                        VStack(spacing: 6){
                            Image("Tantangan")
                            Text("Terima Tantangan")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundStyle(.indigo)
                            
                            Text("Temui YooBuddy, abadikan momen berkenalan, dan tulis pengalamanmu!")
                            //                            .padding(.top, 8)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.gray)
                                .font(.caption)
                        }
                        .padding()
                        
                        .background(Color.white)
                        .cornerRadius(12)
                        
                        VStack(spacing: 4){
                            Image("List YooBuddy")
                            Text("List YooBuddy")
                                .font(.headline)
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
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(Color.gray.opacity(0.05))
                
            }
        }
    }
    
    
}

#Preview {
    QuestPage()
}
