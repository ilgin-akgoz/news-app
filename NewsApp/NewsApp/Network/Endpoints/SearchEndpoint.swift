//
//  SearchEndpoint.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 15.09.2023.
//

import Foundation

enum SearchEndpoint: TargetEndpointProtocol {
    case search(query: String)
    
    private struct Constants {
        static let search  = "v2/everything?q=%@"
    }
    
    var path: String {
        switch self {
        case .search(let query):
            return BaseEndpoint.base.path + String(format: Constants.search, query) + BaseEndpoint.apiKey.path
        }
    }
}
