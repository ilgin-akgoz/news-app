//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 19.09.2023.
//

import UIKit

final class NewsDetailViewController: UIViewController {
    private let newsDetailView = NewsDetailView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.addSubview(newsDetailView)
        NSLayoutConstraint.activate([
            newsDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsDetailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            newsDetailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            newsDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
