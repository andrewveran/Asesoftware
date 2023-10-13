// PhotoDetailView.swift
import SwiftUI

struct PhotoDetailView: View {
    let photo: Photo

    var body: some View {
        VStack {
            Text(photo.title)
            Button("Delete") {
                Task {
                    do {
                        try await PhotoRepository.prod.deletePhoto(photo.id)
                    } catch {
                        // Handle error if necessary
                    }
                }
            }
        }
    }
}
