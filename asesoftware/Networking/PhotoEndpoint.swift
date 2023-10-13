// PhotoEndpoint.swift

import Foundation

enum PhotoEndpoint {
    case retrieveAll
    case deletePhoto(id: Int)
}

extension PhotoEndpoint {
    var url: String {
        return "https://jsonplaceholder.typicode.com"
    }
    
    var path: String {
        switch self {
        case .retrieveAll:
            return "/photos"
        case .deletePhoto(let id):
            return "/photos/\(id)"
        }
    }
    
    var method: String {
        switch self {
        case .retrieveAll:
            return "GET"
        case .deletePhoto:
            return "DELETE"
        }
    }
    
    var request: URLRequest {
        var urlComponents = URLComponents(string: url)!
        urlComponents.path = path
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = method
        return request
    }
}

