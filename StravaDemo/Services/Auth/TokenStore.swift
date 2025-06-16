//
//  TokenStore.swift
//  StravaDemo
//
//  Created by Jason on 6/16/25.
//

protocol TokenStore {
    func load() -> AuthManager.Token?
    func save(_ token: AuthManager.Token)
    func clear()
}

final class KeychainTokenStore: TokenStore {
    let tokenKeychainKey = "jcstravatoken"
    let keychainStore = KeychainStore()
    
    func load() -> AuthManager.Token? {
        return keychainStore.read(key: tokenKeychainKey, type: AuthManager.Token.self)
    }
    func save(_ token: AuthManager.Token) {
        keychainStore.write(key: tokenKeychainKey, value: token)
    }
    func clear() {
        keychainStore.delete(key: tokenKeychainKey)
    }
}
