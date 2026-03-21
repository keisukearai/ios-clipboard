//
//  ClipboardItem.swift
//  ios-clipboard
//

import Foundation

struct ClipboardItem: Identifiable, Codable {
    let id: UUID
    var createdAt: Date
    var category: String
    var content: String

    init(id: UUID = UUID(), createdAt: Date = Date(), category: String, content: String) {
        self.id = id
        self.createdAt = createdAt
        self.category = category
        self.content = content
    }
}
