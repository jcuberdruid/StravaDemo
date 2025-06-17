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
    
    enum APIError: Error {
        case noToken
    }
    func get<T: Decodable>(_ endpointPath: String) async throws -> T {
        guard let url = URL(string: "https://www.strava.com/api/v3\(endpointPath)") else {
            throw URLError(.badURL)
        }
        guard let token = try? await auth.token?.accessToken else { throw APIError.noToken }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (responseData, _) = try await urlSession.data(for: request)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedData = try decoder.decode(T.self, from: responseData)
        return decodedData
    }
}
