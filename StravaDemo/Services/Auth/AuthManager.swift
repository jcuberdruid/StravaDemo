//
//  AuthManager.swift
//  StravaDemo
//
//  Created by Jason on 6/15/25.
//


import Foundation
import SwiftUI
import AuthenticationServices

@Observable final class AuthManager {
    struct Token: Codable {
        let accessToken: String
        let refreshToken: String
        let expiresAt: Date
    }
    
    private let customScheme = "jcstrava"
    
    private let tokenStore: any TokenStore
    
    init(tokenStore: any TokenStore = KeychainTokenStore()) {
        self.tokenStore = tokenStore
        self.isAuthenticated = self._currentToken != nil
    }
    
    private var _currentToken: Token? {
        get { tokenStore.load() }
        set {
            if let token = newValue {
                tokenStore.save(token)
                isAuthenticated = true
            } else {
                tokenStore.clear()
                isAuthenticated = false
            }
        }
    }
    
    var isAuthenticated = false

    var token: Token? {
        get async throws {
            guard let currentToken = self._currentToken else { return nil }
            if currentToken.expiresAt > Date.now.addingTimeInterval(30) {
                return currentToken
            }
            // Refresh since it's expiring in the next 30s
            try await self.performTokenRefresh()
            return self._currentToken
        }
    }
    
    private var oauthURL: URL {
        var components = URLComponents(string: "https://www.strava.com/oauth/mobile/authorize")!
        components.queryItems = [
            .init(name: "client_id", value: StravaSecrets.clientId),
            .init(name: "redirect_uri", value: "\(customScheme)://jcuberdruid.com/callback"),
            .init(name: "response_type", value: "code"),
            .init(name: "approval_prompt", value: "auto"),
            .init(name: "scope", value: "activity:read")
        ]
        
        return components.url!
    }
    
    // TODO consider different error handling
    func login(webAuthenticationSession: WebAuthenticationSession) async throws {
        let callbackURL = try await webAuthenticationSession.authenticate(using: self.oauthURL, callback: .customScheme(self.customScheme), additionalHeaderFields: [:])
        try await handleCallback(url: callbackURL)
    }
    
    private func handleCallback(url: URL) async throws {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let code = components.queryItems?.first(where: { $0.name == "code" })?.value else {
            throw URLError(.badURL)
        }
        self._currentToken = try await getOAuthToken(
            grantType: .authorizationCode,
            grantValue: code
        )
    }
    
    enum GrantType: String {
        case authorizationCode = "authorization_code"
        case refreshToken = "refresh_token"
        
        var grantValueKey: String {
            switch self {
            case .authorizationCode:
                return "code"
            case .refreshToken:
                return "refresh_token"
            }
        }
    }
    private func getOAuthToken(grantType: GrantType, grantValue: String) async throws -> Token {
        var request = URLRequest(url: URL(string: "https://www.strava.com/oauth/token")!)
        request.httpMethod = "POST"
        let body: [String: Any] = [
            "client_id": StravaSecrets.clientId,
            "client_secret": StravaSecrets.clientId,
            "grant_type": grantType.rawValue,
            grantType.grantValueKey: grantValue
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .secondsSince1970
        let tokenResponse = try jsonDecoder.decode(Token.self, from: data)
        return tokenResponse
    }
        
    // TODO add more error cases
    enum TokenRefreshError: Error {
        case missingToken
    }
    private func performTokenRefresh() async throws {
        guard let currentToken = self._currentToken else {
            throw TokenRefreshError.missingToken
        }
        let refreshToken = currentToken.refreshToken
        self._currentToken = try await getOAuthToken(
            grantType: .refreshToken,
            grantValue: refreshToken
        )
    }
}
