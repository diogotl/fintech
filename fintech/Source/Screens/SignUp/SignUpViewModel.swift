import Foundation
import Supabase

enum MyError: Error {
    case invalidInput
    case keychainError
}

enum ValidationError: Error {
    case emptyUsername
    case weakPassword
    case invalidEmail
}

typealias ValidationErrors = [ValidationError]

struct ValidationWrapper: Error {
    let errors: [ValidationError]
}

class SignUpViewModel {

    private let service = "com.fintech.diogo"
    private let client: SupabaseClient

    init(client: SupabaseClient? = nil) {
        if let client = client {
            self.client = client
        } else {
            self.client = SupabaseManager.shared.client
        }
    }

    func register(
        email: String,
        username: String,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        print("invalid")

        let validationErrors = validate(
            username: username,
            email: email,
            password: password
        )

        if !validationErrors.isEmpty {
            completion(.failure(ValidationWrapper(errors: validationErrors)))
            return
        }

        guard !username.isEmpty, !password.isEmpty, !email.isEmpty else {
            completion(.failure(MyError.invalidInput))
            return
        }

        func validate(username: String, email: String, password: String)
            -> [ValidationError]
        {
            var errors: [ValidationError] = []

            if username.isEmpty {
                errors.append(.emptyUsername)
            }

            if password.count < 6 {
                errors.append(.weakPassword)
            }

            if !isValidEmail(email) {
                errors.append(.invalidEmail)
            }

            return errors
        }

        func isValidEmail(_ email: String) -> Bool {
            let regex = #"^\S+@\S+\.\S+$"#
            return email.range(of: regex, options: .regularExpression) != nil
        }

        Task {
            do {

                print("chegou a tsk?")
                let _ = try await client.auth.signUp(
                    email: email,
                    password: password
                )

                let passwordData = password.data(using: .utf8)!
                let status = KeychainHelper.save(
                    service: service,
                    account: username,
                    data: passwordData
                )

                print(status)

                if status != 0 {
                    DispatchQueue.main.async {
                        completion(.failure(MyError.keychainError))
                    }
                    return
                }

                DispatchQueue.main.async {
                    completion(.success(()))
                }
            } catch {
                print("veio")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

    func isUserRegistered(username: String) -> Bool {
        return KeychainHelper.read(service: service, account: username) != nil
    }
}
