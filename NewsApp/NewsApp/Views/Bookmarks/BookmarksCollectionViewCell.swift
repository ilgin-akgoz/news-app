//
//  BookmarksCollectionViewCell.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 20.09.2023.
//

import UIKit

final class BookmarksCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "BookmarksCollectionViewCell"
    private var articleImageURL: URL?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContentView()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setupContentView() {
        contentView.backgroundColor = .systemBackground
    }
    
    private func setupSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "news_placeholder")
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.numberOfLines = 3
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16,
                                 weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
    }
    
    public func configure(with article: Article, imageLoader: @escaping (URL?) -> Void) {
        titleLabel.text = article.title
        articleImageURL = URL(string: article.urlToImage ?? "")
        imageLoader(articleImageURL)
    }
}
