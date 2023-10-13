// PhotoDetailViewModel.swift
import Foundation

@MainActor
class PhotoDetailViewModel: ObservableObject {
    @Published var errorMessage: IdentifiableError? = nil

    func deletePhoto(_ photoId: Int, completion: @escaping () -> Void) async {
        do {
            try await PhotoRepository.prod.deletePhoto(photoId)
            completion()
        } catch {
            errorMessage = IdentifiableError(message: "Failed to delete photo")
        }
    }
}

