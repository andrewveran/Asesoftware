// PhotoListViewModel.swift
import Foundation

@MainActor
class PhotoListViewModel: ObservableObject {
    @Published
    var photos: [Photo] = []
    @Published
    var isLoading: Bool = false
    @Published
    var errorMessage: IdentifiableError? = nil

    func fetchPhotos() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            photos = try await PhotoRepository.prod.photos(.retrieveAll)
        } catch {
            errorMessage = IdentifiableError(message: "Failed to load photos")
        }
    }
}
