//
//  BookmarksViewController.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 7.09.2023.
//

import UIKit

final class BookmarksViewController: UIViewController {
    private let viewModel = BookmarksViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.loadBookmarkedArticles()
    }
    
    private func setupView() {
        let bookmarksView = BookmarksView(viewModel: viewModel)
        view.addSubview(bookmarksView)
        NSLayoutConstraint.activate([
            bookmarksView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bookmarksView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            bookmarksView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            bookmarksView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
