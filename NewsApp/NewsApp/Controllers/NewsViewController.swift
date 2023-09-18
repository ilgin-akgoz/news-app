//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 7.09.2023.
//

import UIKit

final class NewsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        let newsView = NewsView()
        view.addSubview(newsView)
        NSLayoutConstraint.activate([
            newsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            newsView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            newsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
