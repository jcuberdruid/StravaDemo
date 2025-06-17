//
//  ProfileImage.swift
//  StravaDemo
//
//  Created by Jason on 6/16/25.
//

import SwiftUI
import AuthenticationServices
import TipKit

struct AccountSettings: View {
    @Environment(AppDependencies.self) var deps
    @Environment(\.webAuthenticationSession) private var webAuthenticationSession
    
    @State private var showingSheet = false
    let loginTip = LoginTip()
    
    var athlete: Athlete?
    
    var body: some View {
        Button {
            showingSheet.toggle()
        } label: {
            HStack(spacing: 0) {
                deps.auth.isAuthenticated ? nil : (
                    Text("Login")
                        .font(.caption)
                )

                Group {
                    if let url = athlete?.profile, let url = URL(string: url) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .success(let image):
                                image.resizable()
                            default:
                                Image(systemName: "person.crop.circle.fill")
                            }
                        }
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                    }
                }
                .frame(width: 32, height: 32)
                .clipShape(Circle())
            }
            .popoverTip(deps.auth.isAuthenticated ? nil : loginTip)
            .task {
                try? Tips.resetDatastore()
                try? Tips.configure([.displayFrequency(.immediate)])
            }
        }
        .sheet(isPresented: $showingSheet) {
            NavigationStack {
                List {
                    Section {
                        if self.deps.auth.isAuthenticated && self.athlete?.firstname != nil {
                            Text("\(athlete!.firstname) \(athlete!.lastname)")
                        }
                        Button(
                            self.deps.auth.isAuthenticated ? "Logout" : "Login",
                            action: {
                                if self.deps.auth.isAuthenticated {
                                    self.deps.auth.signOut()
                                    showingSheet = false
                                } else {
                                    Task {
                                        try await self.deps.auth.login(webAuthenticationSession: webAuthenticationSession)
                                        showingSheet = false
                                    }
                                    
                                }
                            }
                        )
                    } header: {
                        if self.deps.auth.isAuthenticated && self.athlete?.firstname != nil {
                            Text("Logged in as")
                        }
                    } footer: {
                        if !self.deps.auth.isAuthenticated || self.athlete?.firstname == nil {
                            Text("Login with your Strava account for a personalized experience")
                        }
                    }
                }
                .navigationTitle("Account")
            }
        }
    }
}
