// PhotoRepository.swift
import Foundation

struct PhotoRepository {
    var photos: (PhotoEndpoint) async throws -> [Photo]
    var deletePhoto: (Int) async throws -> Void
}

extension PhotoRepository {
    static let prod = PhotoRepository(photos: { endpoint in
        let (data, response) = try await URLSession.shared.data(for: endpoint.request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse) // or create a custom error
        }
        
        let photos = try JSONDecoder().decode([Photo].self, from: data)
        return photos
    }, deletePhoto: { photoId in
        let (_, response) = try await URLSession.shared.data(for: PhotoEndpoint.deletePhoto(id: photoId).request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse) // or create a custom error
        }
    })
}
