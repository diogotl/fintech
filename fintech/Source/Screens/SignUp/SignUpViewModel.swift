import Foundation
import UIKit

enum MyError: Error {
    case invalidInput
    case keychainError
}

class SignUpViewModel {

    private let service = "com.fintech.diogo"

    func register(
        email: String, username: String, password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        guard !username.isEmpty, !password.isEmpty, !email.isEmpty else {
            completion(.failure(MyError.invalidInput))
            return
        }
        let passwordData = password.data(using: .utf8)!
        let status = KeychainHelper.save(service: service, account: username, data: passwordData)
        if status != 0 {
            print(status)
            completion(.failure(MyError.keychainError))
            return
        }
        completion(.success(()))
    }

    func isUserRegistered(username: String) -> Bool {
        return KeychainHelper.read(service: service, account: username) != nil
    }
}
