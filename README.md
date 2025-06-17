# Strava Demo
Small but scalable SwiftUI app to view activities and stats from Strava API.

## Prerequisites
* Xcode 16.4
* Strave app (client ID + client secret + callback domain) with credentials configured in [`StravaSecrets.sample.swift`](https://github.com/jcuberdruid/StravaDemo/blob/main/StravaDemo/Services/StravaSecrets.sample.swift).

Note that you can just uncomment that file to expose any `StravaSecrets` struct even with invalid values to successfully build the app and use it in demo mode.

If you use real Strava app credentials, ensure you login with the same user as the one that created the app on Strava, unless you've received an increase from Strava from the default limit of 1 user. 

## Things to improve/address

* Error handling in general—we have some custom error types, but often not propagated all the way to the UI and not handled
* Accessibility modifiers throughout
* Explore which service classes should be actors for thread-safety (would have to handle publishing updates differently since actors cannot be Observable)
* Handle only a subset of requested scopes being granted by user 
* Improve Strava data Models, many properties are strings that should be enums (such as type and sportType). Also re-examine which properties are actually optional
* Reconsider whether to use View Models. I went with it in the interest of time, but I think with modern `@Observable` and `@Environment` patterns, we might not need the View Models. 
* Implement pagination and lazy/progressive loading for Activities
* Add non-metric unit options per user preference 
* Streamline the stat card population (strongly typed values for unified formatting)
* Cache/persist data locally to reduce API calls (currently only auth token is persisted in Keychain) 
* Add tests: since most of our interfaces are modeled as `protocol`s (see the `*Service` `protocol`s for easily providing demo data when signed out), mocking for unit tests should be fairly straightforward. And should this grow into a production app UI tests might also make sense.

