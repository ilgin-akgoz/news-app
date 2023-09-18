//
//  LoginViewModel.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 11.09.2023.
//

import UIKit
import FirebaseAuth

final class LoginViewModel {
    public func signIn(with email: String, _ password: String, completion: @escaping (Error?) -> Void) {
        guard !email.isEmpty, !password.isEmpty else {
            return
        }

        let userRequest = UserRequestModel(email: email, password: password)
        AuthService.shared.signIn(with: userRequest) { error in
            if let error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
}

