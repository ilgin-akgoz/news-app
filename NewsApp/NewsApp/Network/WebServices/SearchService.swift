//
//  SearchService.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 18.09.2023.
//

import Foundation

protocol SearchServiceProtocol {
    func getSearchResults(for query: String) async throws -> NewsResponseModel
}

final class SearchService: SearchServiceProtocol, BaseServiceProtocol {
    typealias Endpoint = SearchEndpoint
    let networkLoader: NetworkLoaderProtocol
    init(networkLoader: NetworkLoaderProtocol = NetworkLoaderProvider.shared.networkLoader) {
        self.networkLoader = networkLoader
    }
    func getSearchResults(for query: String) async throws -> NewsResponseModel {
        return try await request(with: RequestObject(
            url: build(endpoint: .search(query: query))
            ),
            responseModel: NewsResponseModel.self)
    }
}
