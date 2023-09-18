//
//  URLSessionProtocol.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 18.09.2023.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }
