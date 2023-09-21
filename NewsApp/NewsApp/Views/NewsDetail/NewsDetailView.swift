//
//  NewsDetailView.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 19.09.2023.
//

import UIKit

final class NewsDetailView: UITableView {
    private var viewModel: NewsDetailViewModel?
    
    init() {
        super.init(frame: .zero, style: .plain)
        register(NewsDetailTableViewCell.self, forCellReuseIdentifier: NewsDetailTableViewCell.cellIdentifier)
        viewModel = NewsDetailViewModel(article: nil)
        dataSource = viewModel
        delegate = viewModel
        separatorStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    public func configure(with article: Article) {
        viewModel?.article = article
        reloadData()
    }
}
