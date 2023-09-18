//
//  NetworkLoaderProtocol.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 18.09.2023.
//

import Foundation

protocol NetworkLoaderProtocol {
    var session: URLSessionProtocol { get set }
    var decoder: JSONDecoder { get set }

    func request<T: Decodable>(with requestObject: RequestObject, responseModel: T.Type) async throws -> T
}

extension NetworkLoaderProtocol {
    func request<T: Decodable>(with requestObject: RequestObject, responseModel: T.Type) async throws -> T {
        let (data, response) = try await session.data(for: prepareURLRequest(with: requestObject), delegate: nil)
        let successCodeRange = 200...299
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { throw NewsError.badResponse }
        guard successCodeRange.contains(statusCode) else {
            throw NewsError.httpError(status: HTTPStatus(rawValue: statusCode) ?? .notValidCode)
        }
        do {
            let decodedData = try decoder.decode(responseModel, from: data)
            return decodedData
        } catch {
            throw NewsError.mappingFailed(data: data)
        }
    }

    private func prepareURLRequest(with requestObject: RequestObject) throws -> URLRequest {
        guard let url = URL(string: requestObject.url) else { throw NewsError.badURL(requestObject.url) }
        var request = URLRequest(url: url)
        request.httpMethod = requestObject.method.rawValue
        request.allHTTPHeaderFields = requestObject.headers
        request.httpBody = requestObject.data?.encode()

        return request
    }
}
