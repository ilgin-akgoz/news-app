//
//  ConfigurationProtocol.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 15.09.2023.
//

import Foundation

protocol ConfigurationProtocol {}

extension ConfigurationProtocol {
    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw ConfigurationError.missingKey
        }
        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw ConfigurationError.invalidValue
        }
    }
}

enum ConfigurationError: Swift.Error {
    case missingKey, invalidValue
}
