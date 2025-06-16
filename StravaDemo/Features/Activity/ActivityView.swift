//
//  ActivityView.swift
//  StravaDemo
//
//  Created by Jason on 6/16/25.
//

import SwiftUI

struct ActivityView: View {
    @Environment(AppDependencies.self) var deps
    @Environment(\.webAuthenticationSession) private var webAuthenticationSession

    var body: some View {
        NavigationStack {
            ActivityListView()
        }
    }
}

/* TODO
#Preview {
    ActivityView(deps: <#T##arg#>, webAuthenticationSession: <#T##arg#>)
}
*/
