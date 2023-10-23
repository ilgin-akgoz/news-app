//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 19.09.2023.
//

import UIKit

protocol NewsViewModelDelegate: AnyObject {
    func willLoadArticles()
    func didLoadArticles()
}

final class NewsViewModel: NSObject {
    private let searchService: SearchServiceProtocol = SearchService()
    private let topHeadlinesService: TopHeadlinesServiceProtocol = TopHeadlinesService()
    weak var delegate: NewsViewModelDelegate?
    let bookmarksViewModel = BookmarksViewModel()
    private var searchQuery: String = ""
    var articles: [Article] = []
    
    var isFetchingArticles = false {
        didSet {
            DispatchQueue.main.async {
                if self.isFetchingArticles {
                    self.delegate?.willLoadArticles()
                } else {
                    self.delegate?.didLoadArticles()
                }
            }
        }
    }
    
    func fetchTopHeadlinesResults(for category: String) async {
        isFetchingArticles = true
        do {
            articles.removeAll()
            let topHeadlinesResults = try await fetchTopHeadlinesResponse(category: category)
            articles = topHeadlinesResults.articles ?? []
            isFetchingArticles = false
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func fetchTopHeadlinesResponse(category: String) async throws -> NewsResponseModel {
        let response = try await topHeadlinesService.getTopHeadlines(for: category)
        return response
    }
    
    private func fetchSearchResults() async {
        do {
            let searchResults = try await fetchSearchResponse()
            articles = searchResults.articles ?? []
            isFetchingArticles = false
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func fetchSearchResponse() async throws -> NewsResponseModel {
        let response = try await searchService.getSearchResults(for: searchQuery)
        return response
    }
    
    func removeBookmark(_ article: Article) {
        var bookmarks = UserDefaults.standard.array(forKey: "bookmarkedArticles") as? [Data] ?? []
        bookmarks.removeAll { data in
            if let bookmarkedArticle = try? JSONDecoder().decode(Article.self, from: data),
               bookmarkedArticle.title == article.title {
                return true
            }
            return false
        }
        UserDefaults.standard.set(bookmarks, forKey: "bookmarkedArticles")
    }
    
    func saveBookmark(_ article: Article) {
        var bookmarks = UserDefaults.standard.array(forKey: "bookmarkedArticles") as? [Data] ?? []
        if let encodedArticle = try? JSONEncoder().encode(article) {
            bookmarks.append(encodedArticle)
            UserDefaults.standard.set(bookmarks, forKey: "bookmarkedArticles")
        }
    }
}

extension NewsViewModel: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchQuery = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
        
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
        
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchQuery.count >= 3 {
            articles.removeAll()
            isFetchingArticles = true
            Task {
                await fetchSearchResults()
            }
        }
    }
}

extension NewsViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: NewsCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? NewsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.delegate = bookmarksViewModel
        
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
            let navController = detailVC.viewControllers?[0] as? UINavigationController {
            navController.pushViewController(vc, animated: true)
        }
    }
}

