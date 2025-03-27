//
//  Form.swift
//  YooHoo
//
//  Created by Yonathan Handoyo on 27/03/25.
//

import SwiftUI
import UIKit
import Speech
import SwiftData

struct ExperienceFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var modelContext
    @State private var name: String = ""
    @State private var note: String = ""
    @State private var selectedImage: UIImage?
    @State private var showImagePicker: Bool = false
    @State private var showActionSheet: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var isRecording = false
    private let speechRecognizer = SpeechRecognizer()
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Gimana pengalamanmu?")
                    .font(.system(size: 24))
                    .bold()
                
                Text("Foto bareng, catat nama, dan tulis hal seru dari obrolan kalian!")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .padding(.trailing, 100)
            }
            
            Button(action: {
                showActionSheet = true
            }) {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 160)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .clipped()
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                        .foregroundColor(.gray)
                }
            }
            
            Button("Add Photos") {
                showActionSheet = true
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
            .background(Color.indigo)
            .cornerRadius(20)
            
            VStack(spacing: 0) {
                TextField("Masukkan nama", text: $name)
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Divider().padding(.horizontal, 12)
                
                HStack {
                    TextField("Share key topics or fun takeaways!", text: $note, axis: .vertical)
                        .padding().lineLimit(5)
                        .onAppear {
                            speechRecognizer.requestPermission()
                        }
                    
                    Button(action: {
                        if isRecording {
                            speechRecognizer.stopRecording()
                        } else {
                            speechRecognizer.startRecording { result in
                                self.note = result
                            }
                        }
                        isRecording.toggle()
                    }) {
                        Image(systemName: isRecording ? "mic.fill" : "mic")
                            .foregroundColor(isRecording ? .red : .gray)
                            .padding()
                    }
                }
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
            
            Spacer()
        }
        .padding()
        .navigationBarItems(
            leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }
                .foregroundColor(.blue),
            
            trailing: Button("Add") {
                print("masuk ke add nih")
                let imagePath = saveImageToFileSystem(selectedImage) ?? "default_image"
                let newBuddy = Buddy(
                    name: name,
                    image: imagePath,
                    description: note
                )
                modelContext.insert(newBuddy)
                try? modelContext.save()
                presentationMode.wrappedValue.dismiss()
                print(newBuddy.name)
                print(newBuddy.image)
                print(newBuddy.experience)
                print("sudah masuk")
            }
                .disabled(name.isEmpty || note.isEmpty || selectedImage == nil)
                .foregroundColor(name.isEmpty || note.isEmpty || selectedImage == nil ? .gray : .blue)
        )
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(title: Text("Pilih Sumber Gambar"), buttons: [
                .default(Text("Kamera")) {
                    sourceType = .camera
                    showImagePicker = true
                },
                .default(Text("Galeri")) {
                    sourceType = .photoLibrary
                    showImagePicker = true
                },
                .cancel()
            ])
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage, sourceType: sourceType)
        }
    }
    
    // Fungsi untuk menyimpan gambar ke file system dan mengembalikan path-nya
    private func saveImageToFileSystem(_ image: UIImage?) -> String? {
        guard let image = image,
              let data = image.jpegData(compressionQuality: 0.8) else { return nil }
        
        let fileName = UUID().uuidString + ".jpeg"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            try data.write(to: fileURL)
            return fileName
        } catch {
            print("Error saving image: \(error)")
            return nil
        }
    }
}

// MARK: - Image Picker View
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    var sourceType: UIImagePickerController.SourceType
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }
    }
}

//#Preview {
//    NavigationView {
//        ExperienceFormView()
//    }
//}
