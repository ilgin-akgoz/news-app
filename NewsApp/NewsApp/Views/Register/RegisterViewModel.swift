//
//  RegisterViewModel.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 15.09.2023.
//

import Foundation
import FirebaseAuth

final class RegisterViewModel {
    public func register(with email: String, _ password: String, completion: @escaping (Error?) -> Void) {
        guard !email.isEmpty, !password.isEmpty else {
            return
        }
        
        let userRequest = UserRequestModel(email: email, password: password)
        AuthService.shared.registerUser(with: userRequest) { _, error in
            if let error {
                completion(error)
            }
        }
    }
}
