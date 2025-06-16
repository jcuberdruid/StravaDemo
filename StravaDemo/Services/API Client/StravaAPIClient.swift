//
//  StravaAPIClient.swift
//  StravaDemo
//
//  Created by Jason on 6/16/25.
//

import Foundation

final class StravaAPIClient {
    private let urlSession: URLSession
    private let auth: AuthManager
    
    init(urlSession: URLSession = .shared, auth: AuthManager) {
        self.urlSession = urlSession
        self.auth = auth
    }
    
    enum Endpoint: String {
        case athlete = "/athlete"
        
        var url: URL {
            return URL(string: "https://www.strava.com/api/v3\(self.rawValue)")!
        }
    }
    
    enum APIError: Error {
        case noToken
    }
    func get<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard let token = try? await auth.token?.accessToken else { throw APIError.noToken }
        
        var request = URLRequest(url: endpoint.url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (responseData, _) = try await urlSession.data(for: request)
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(T.self, from: responseData)
        return decodedData
    }
}
