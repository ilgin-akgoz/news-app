//
//  RegisterView.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 15.09.2023.
//

import UIKit

final class RegisterView: UIView {
    private let viewModel = RegisterViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        addSubview(emailField)
        addSubview(passwordField)
        addSubview(registerButton)
        addSubview(successLabel)
        
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private let successLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Registration successful! You can now sign in."
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sign Up"
        label.font = .newYork(size: 32)
        return label
    }()
    
    private let emailField: UITextField = {
        let emailField = UITextField()
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.placeholder = "Email"
        emailField.autocapitalizationType = .none
        emailField.borderStyle = .roundedRect
        return emailField
    }()
    
    private let passwordField: UITextField = {
        let passwordField = UITextField()
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.placeholder = "Password"
        passwordField.borderStyle = .roundedRect
        passwordField.autocapitalizationType = .none
        passwordField.isSecureTextEntry = true
        return passwordField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Sign Up", for: .normal)
        return button
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            
            emailField.centerXAnchor.constraint(equalTo: centerXAnchor),
            emailField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 100),
            emailField.widthAnchor.constraint(equalToConstant: 200),
            emailField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordField.centerXAnchor.constraint(equalTo: centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            passwordField.widthAnchor.constraint(equalToConstant: 200),
            passwordField.heightAnchor.constraint(equalToConstant: 40),
            
            registerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            registerButton.widthAnchor.constraint(equalToConstant: 200),
            registerButton.heightAnchor.constraint(equalToConstant: 40),
            
            successLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            successLabel.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20),
        ])
    }
    
    @objc private func didTapRegisterButton() {
        viewModel.register(with: emailField.text ?? "", passwordField.text ?? "") { [weak self] error in
            if let error {
                print("Sign-up error: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self?.successLabel.isHidden = false
                }
            }
        }
    }
}
