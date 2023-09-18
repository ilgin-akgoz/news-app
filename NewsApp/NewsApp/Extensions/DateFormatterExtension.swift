//
//  DateFormatterExtension.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 19.09.2023.
//

import Foundation

extension DateFormatter {
    static let localizedFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
}
