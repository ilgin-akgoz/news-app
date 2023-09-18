//
//  ErrorResponse.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 18.09.2023.
//

import Foundation

final class ErrorResponse: Decodable {
    var code: Int?
    var message: String?
    var messages: [String: String]?
}
