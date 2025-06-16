//
//  AppDependencies.swift
//  StravaDemo
//
//  Created by Jason on 6/15/25.
//
import Observation

@Observable final class AppDependencies {
    let auth: AuthManager
    
    init() {
        auth = AuthManager()
    }
}
