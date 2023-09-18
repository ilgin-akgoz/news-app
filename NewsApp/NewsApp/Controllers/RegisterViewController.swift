//
//  RegisterViewController.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 15.09.2023.
//

import UIKit

final class RegisterViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView()
    }
    
    private func setupView() {
        let registerView = RegisterView()
        view.addSubview(registerView)
        NSLayoutConstraint.activate([
            registerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            registerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            registerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            registerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
