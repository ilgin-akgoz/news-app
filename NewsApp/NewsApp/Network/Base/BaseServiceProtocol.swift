//
//  BaseServiceProtocol.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 18.09.2023.
//

import Foundation

protocol BaseServiceProtocol {
    associatedtype Endpoint: TargetEndpointProtocol
    var networkLoader: NetworkLoaderProtocol { get }
    func request<T: Decodable>(with requestObject: RequestObject, responseModel: T.Type) async throws -> T
}

extension BaseServiceProtocol {
    func request<T: Decodable>(with requestObject: RequestObject, responseModel: T.Type) async throws -> T {
        try await networkLoader.request(with: requestObject, responseModel: responseModel)
    }
    func build(endpoint: Endpoint) -> String {
        endpoint.path
    }
}
