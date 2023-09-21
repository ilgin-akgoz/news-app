//
//  NewsDetailViewModel.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 19.09.2023.
//

import UIKit

final class NewsDetailViewModel: NSObject {
    var article: Article?
    
    init(article: Article?) {
        self.article = article
    }
}

extension NewsDetailViewModel: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsDetailTableViewCell.cellIdentifier) as? NewsDetailTableViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.row {
        case 0:
            cell.configureTitleLabel(text: article?.title)
        case 1:
            let url = URL(string: article?.urlToImage ?? "")
            cell.configureImage(imageURL: url) { imageURL in
                if let imageURL {
                    ImageManager.shared.fetchImage(url: imageURL) { result in
                        switch result {
                        case .success(let imageData):
                            DispatchQueue.main.async {
                                cell.articleImageView.image = UIImage(data: imageData)
                            }
                        case .failure(let error):
                            print("Error loading image: \(error)")
                        }
                    }
                }
            }
        case 2:
            let text = "Author: \(article?.author ?? "N/A")"
            cell.configureAuthorLabel(text: text)
        case 3:
            cell.configureDescriptionLabel(text: article?.description)
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

