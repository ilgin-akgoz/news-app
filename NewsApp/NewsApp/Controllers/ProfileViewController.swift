//
//  ProfileViewController.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 7.09.2023.
//

import UIKit

final class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // temporary code, will be moved to view and view model files
    private func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogoutButton))
    }
    
    @objc private func didTapLogoutButton() {
        AuthService.shared.signOut { [weak self] error in
            guard let self else { return }
            
            if let error {
                print(error.localizedDescription)
                return
            }
            
            if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
}
