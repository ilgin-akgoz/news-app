//
//  NetworkLoaderProvider.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 18.09.2023.
//

import Foundation

final class NetworkLoaderProvider {
    static let shared: NetworkLoaderProvider = NetworkLoaderProvider()
    let networkLoader: NetworkLoaderProtocol
    private init() {
        networkLoader = NetworkLoader()
    }
}
