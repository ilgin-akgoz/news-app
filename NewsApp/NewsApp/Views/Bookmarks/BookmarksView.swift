//
//  BookmarksView.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 20.09.2023.
//

import UIKit

final class BookmarksView: UIView {
    private let viewModel: BookmarksViewModel
        
    init(viewModel: BookmarksViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false        
        addSubview(collectionView)
        
        viewModel.delegate = self
        
        setupConstraints()
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.isHidden = false
        collectionView.alpha = 1
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(BookmarksCollectionViewCell.self,
                                forCellWithReuseIdentifier: BookmarksCollectionViewCell.cellIdentifier)
    
        return collectionView
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
}

extension BookmarksView: BookmarksViewModelDelegate {
    func reloadDataCall() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
