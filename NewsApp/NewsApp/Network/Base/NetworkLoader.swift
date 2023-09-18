//
//  NetworkLoader.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 18.09.2023.
//

import Foundation

final class NetworkLoader: NetworkLoaderProtocol {
    var session: URLSessionProtocol = URLSession.shared
    var decoder: JSONDecoder = JSONDecoder()
}
