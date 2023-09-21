//
//  BookmarksViewModel.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 20.09.2023.
//

import UIKit

protocol BookmarksViewModelDelegate: AnyObject {
    func reloadDataCall()
}

final class BookmarksViewModel: NSObject {
    weak var delegate: BookmarksViewModelDelegate?
    var articles: [Article] = []
    
    func loadBookmarkedArticles() {
        if let bookmarksData = UserDefaults.standard.array(forKey: "bookmarkedArticles") as? [Data] {
            for data in bookmarksData {
                if let bookmarkedArticle = try? JSONDecoder().decode(Article.self, from: data) {
                    articles.append(bookmarkedArticle)
                }
            }
        }
    }
}

extension BookmarksViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BookmarksCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? BookmarksCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if articles.indices.contains(indexPath.row) {
            let article = articles[indexPath.row]
            cell.configure(with: article) { imageURL in
                if let imageURL {
                    ImageManager.shared.fetchImage(url: imageURL) { result in
                        switch result {
                        case .success(let imageData):
                            DispatchQueue.main.async {
                                cell.imageView.image = UIImage(data: imageData)
                            }
                        case .failure(let error):
                            print("Error loading image: \(error)")
                        }
                    }
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30)
        
        return CGSize(
            width: width,
            height: width / 3
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = NewsDetailViewController()

        if articles.indices.contains(indexPath.row) {
            let article = articles[indexPath.row]
            let view = NewsDetailView()
            view.configure(with: article)
            vc.view = view
        }

        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let firstWindow = firstScene.windows.first else { return }

        if let detailVC = firstWindow.rootViewController as? TabBarController,
            let navController = detailVC.viewControllers?[1] as? UINavigationController {
            navController.pushViewController(vc, animated: true)
        }
    }
}

extension BookmarksViewModel: NewsCollectionViewCellDelegate {
    func didTapBookmarkButton() {
        loadBookmarkedArticles()
        self.delegate?.reloadDataCall()
    }
}

