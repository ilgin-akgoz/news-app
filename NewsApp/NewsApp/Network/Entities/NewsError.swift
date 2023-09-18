//
//  NewsError.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 18.09.2023.
//

import Foundation

enum NewsError: Error, Equatable {
    case httpError(status: HTTPStatus, data: Data? = nil)
    case badURL(_ url: String)
    case unknown(error: NSError)
    case customError(_ code: Int, _ message: String, _ data: Data? = nil)
    case mappingFailed(data: Data? = nil)
    case badResponse

    var errorCode: Int {
        switch self {
        case .httpError(let error, _):
            return error.rawValue
        case .unknown(let error):
            return error.code
        case .customError(let code, _, _):
            return code
        case .mappingFailed:
            return 0
        case .badResponse:
            return 0
        case .badURL:
            return 0
        }
    }

    var response: ErrorResponse? {
        getResponse()
    }
}

extension NewsError {
    private func getResponse() -> ErrorResponse? {
        switch self {
        case .httpError(_, let data), .customError(_, _, let data):
            if let data = data {
                let response = try? JSONDecoder().decode(ErrorResponse.self, from: data)
                return response
            }
            return nil
        case .badResponse, .mappingFailed, .unknown, .badURL:
            return nil
        }
    }
}
