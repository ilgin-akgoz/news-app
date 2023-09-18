//
//  Configuration.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 15.09.2023.
//

import Foundation

final class Configuration: ConfigurationProtocol {
    static var baseURL: String {
        let url: String? = try? self.value(for: "BASE_URL")
        return url ?? ""
    }
    
    static var apiKey: String {
        let key: String? = try? self.value(for: "API_KEY")
        guard let key, !key.isEmpty else {
            return ""
        }
        return key
    }
}
