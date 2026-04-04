//
// SupabaseManager.swift
// Centralized singleton to provide a shared SupabaseClient instance.
//
// Usage:
//   - Ensure your Info.plist contains the keys `SUPABASE_URL` and `SUPABASE_KEY`
//     (these were added to your Info.plist).
//   - Access the shared client with `SupabaseManager.shared.client`
//   - For tests you can instantiate `SupabaseManager(client:)` with a mock client.
//
// Note: Keep your anon/public key secure. For production consider using a secure
// distribution mechanism (not hardcoding in source).
//

import Foundation
import Supabase

final class SupabaseManager {

    /// Shared singleton instance
    static let shared = SupabaseManager()

    /// The Supabase client used across the app
    let client: SupabaseClient

    /// Default initializer — reads configuration from Info.plist and constructs the client.
    /// This initializer will terminate the app with a clear message if configuration is missing or invalid.
    private init() {
        // Read values from Info.plist. These keys should exist in the app's Info.plist.
        let urlString =
            Bundle.main.object(forInfoDictionaryKey: "SUPABASE_URL") as? String
        let apiKey =
            Bundle.main.object(forInfoDictionaryKey: "SUPABASE_KEY") as? String

        guard let urlStringUnwrapped = urlString, !urlStringUnwrapped.isEmpty,
            let apiKeyUnwrapped = apiKey, !apiKeyUnwrapped.isEmpty
        else {
            fatalError(
                """
                Supabase configuration missing. Add SUPABASE_URL and SUPABASE_KEY to Info.plist \
                or initialize SupabaseManager with a custom SupabaseClient for testing.
                """
            )
        }

        guard let url = URL(string: urlStringUnwrapped) else {
            fatalError(
                "SUPABASE_URL in Info.plist is not a valid URL: \(urlStringUnwrapped)"
            )
        }

        self.client = SupabaseClient(
            supabaseURL: url,
            supabaseKey: apiKeyUnwrapped,
            options: SupabaseClientOptions(
                auth: .init(
                    emitLocalSessionAsInitialSession: true
                )
            )
        )
    }

    init(client: SupabaseClient) {
        self.client = client
    }

}
