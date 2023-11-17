//
//  HistoryModel.swift
//  SwiftUIWebView
//
//  Created by Delstun McCray on 11/15/23.
//

import Foundation

struct HistoryModel: Identifiable, Codable {
    var id = UUID()
    let title: String
    let url: URL
    let timestamp: Date
}
