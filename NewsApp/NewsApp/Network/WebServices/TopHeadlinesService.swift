//
//  TopHeadlinesService.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 18.09.2023.
//

import Foundation

protocol TopHeadlinesServiceProtocol {
    func getTopHeadlines(for category: String) async throws -> NewsResponseModel
}

final class TopHeadlinesService: TopHeadlinesServiceProtocol, BaseServiceProtocol {
    typealias Endpoint = TopHeadlinesEndpoint
    let networkLoader: NetworkLoaderProtocol
    init(networkLoader: NetworkLoaderProtocol = NetworkLoaderProvider.shared.networkLoader) {
        self.networkLoader = networkLoader
    }
    func getTopHeadlines(for category: String) async throws -> NewsResponseModel {
        return try await request(with: RequestObject(
            url: build(endpoint: .topHeadlines(category: category))
            ),
            responseModel: NewsResponseModel.self)
    }
}
