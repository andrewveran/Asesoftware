// PhotoDetailView.swift
import SwiftUI

struct PhotoDetailView: View {
    let photo: Photo
    @StateObject private var viewModel = PhotoDetailViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text(photo.title)
            AsyncImage(url: URL(string: photo.url)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .scaledToFit()
            
            Button("Delete Photo") {
                Task {
                    await viewModel.deletePhoto(photo.id) {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .padding(.top, 20)
        }
        .padding()
        .navigationTitle("Photo Details")
        .alert(item: $viewModel.errorMessage) { error in
            Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
        }
    }
}
