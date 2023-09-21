//
//  TopHeadlinesEndpoint.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 18.09.2023.
//

import Foundation

enum TopHeadlinesEndpoint: TargetEndpointProtocol {
    case topHeadlines(category: String)
    
    private struct Constants {
        static let topHeadlines = "v2/top-headlines?country=us&category=%@"
    }
    
    var path: String {
        switch self {
        case .topHeadlines(let category):
            return BaseEndpoint.base.path + String(format: Constants.topHeadlines, category) + BaseEndpoint.apiKey.path
        }
    }
}
