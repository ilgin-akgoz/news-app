//
//  NewsCollectionViewCell.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 19.09.2023.
//

import UIKit

protocol NewsCollectionViewCellDelegate: AnyObject {
    func didTapBookmarkButton()
}

final class NewsCollectionViewCell: UICollectionViewCell {
    weak var delegate: NewsCollectionViewCellDelegate?

    static let cellIdentifier = "NewsCollectionViewCell"
    private var articleImageURL: URL?
    var article: Article?
    private let viewModel = NewsViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContentView()
        setupSubviews()
        setupConstraints()
        
        bookmarkButton.addTarget(self, action: #selector(didTapBookmarkButton), for: .touchUpInside)
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
        contentView.addSubview(bookmarkButton)
    }
    
    private let bookmarkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        button.tintColor = .systemPurple
        return button
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "news_placeholder")
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
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
            
            titleLabel.topAnchor.constraint(equalTo: bookmarkButton.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            bookmarkButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            bookmarkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
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
        
        self.article = article
    }
    
    @objc private func didTapBookmarkButton() {
        bookmarkButton.isSelected.toggle()
        
        guard let article else {
            return
        }
        
        if bookmarkButton.isSelected {
            viewModel.saveBookmark(article)
        } else {
            viewModel.removeBookmark(article)
        }
        
        delegate?.didTapBookmarkButton()
    }
}
