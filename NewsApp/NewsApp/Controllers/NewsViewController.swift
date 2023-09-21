//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 7.09.2023.
//

import UIKit

enum NewsCategory: String, CaseIterable {
    case general
    case business
    case entertainment
    case health
    case science
    case sports
    case technology

    var title: String {
        return self.rawValue.capitalized
    }
}

final class NewsViewController: UIViewController {
    private let viewModel = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setCategoriesButton()
        
        Task {
            await viewModel.fetchTopHeadlinesResults(for: "general")
        }
    }
    
    private func setupView() {
        let newsView = NewsView(viewModel: viewModel)
        view.addSubview(newsView)
        NSLayoutConstraint.activate([
            newsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            newsView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            newsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func setCategoriesButton() {
        var categoryActions: [UIAction] = []

        for category in NewsCategory.allCases {
            let action = UIAction(title: category.title) { [weak self] _ in
                guard let self else { return }
                Task {
                    await self.viewModel.fetchTopHeadlinesResults(for: category.rawValue)
                }
            }
            categoryActions.append(action)
        }

        let menu = UIMenu(title: "Categories", children: categoryActions)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "ellipsis"), primaryAction: nil, menu: menu)
        navigationItem.rightBarButtonItem?.tintColor = .systemPurple
    }
}
