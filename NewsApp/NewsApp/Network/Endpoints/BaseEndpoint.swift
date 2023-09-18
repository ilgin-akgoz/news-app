//
//  BaseEndpoint.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 15.09.2023.
//

import Foundation

enum BaseEndpoint: TargetEndpointProtocol {
    case base
    case apiKey
    var path: String {
        switch self {
        case .base:
            return Configuration.baseURL
        case .apiKey:
            return Configuration.apiKey
        }
    }
}
