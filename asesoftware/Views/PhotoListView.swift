// PhotoListView.swift
import SwiftUI

struct PhotoListView: View {
    @StateObject private var viewModel = PhotoListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.photos) { photo in
                NavigationLink(destination: PhotoDetailView(photo: photo)) {
                    HStack {
                        // Thumbnail Image
                        AsyncImage(url: URL(string: photo.thumbnailUrl)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                        
                        // Title
                        Text(photo.title)
                            .font(.body)
                            .padding(.leading, 10)
                    }
                }
            }
            .navigationTitle("Photos")
            .task {
                await viewModel.fetchPhotos()
            }
            .alert(item: $viewModel.errorMessage) { error in
                            Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
                        }
        }
    }
}
