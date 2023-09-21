//
//  NewsDetailTableViewCell.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 20.09.2023.
//

import UIKit

final class NewsDetailTableViewCell: UITableViewCell {
    static let cellIdentifier = "NewsDetailTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(articleImageView)
        addSubview(titleLabel)
        addSubview(authorLabel)
        addSubview(descriptionLabel)
        
        isUserInteractionEnabled = false
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .justified
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            articleImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            articleImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            articleImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            articleImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            articleImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            articleImageView.heightAnchor.constraint(equalToConstant: 200),
            
            authorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            authorLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 8),
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
    }
    
    public func configureTitleLabel(text: String?) {
        titleLabel.text = text
    }
    
    public func configureAuthorLabel(text: String?) {
        authorLabel.text = text
    }
    
    public func configureDescriptionLabel(text: String?) {
        descriptionLabel.text = text
    }
    
    public func configureImage(imageURL: URL?, imageLoader: @escaping (URL?) -> Void) {
        imageLoader(imageURL)
    }
}
