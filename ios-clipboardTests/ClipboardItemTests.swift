//
//  ClipboardItemTests.swift
//  ios-clipboardTests
//

import Testing
import Foundation
@testable import ios_clipboard

@Suite("ClipboardItem")
struct ClipboardItemTests {

    @Test func initSetsCategory() {
        let item = ClipboardItem(category: "url", content: "https://example.com")
        #expect(item.category == "url")
    }

    @Test func initSetsContent() {
        let item = ClipboardItem(category: "url", content: "https://example.com")
        #expect(item.content == "https://example.com")
    }

    @Test func defaultCategoryIsEmpty() {
        let item = ClipboardItem(category: "", content: "test")
        #expect(item.category.isEmpty)
    }

    @Test func twoItemsHaveUniqueIDs() {
        let a = ClipboardItem(category: "", content: "same")
        let b = ClipboardItem(category: "", content: "same")
        #expect(a.id != b.id)
    }

    @Test func customIDIsPreserved() {
        let id = UUID()
        let item = ClipboardItem(id: id, category: "x", content: "y")
        #expect(item.id == id)
    }

    @Test func createdAtIsSetToNow() {
        let before = Date()
        let item = ClipboardItem(category: "", content: "t")
        let after = Date()
        #expect(item.createdAt >= before)
        #expect(item.createdAt <= after)
    }

    @Test func codableRoundtrip() throws {
        let item = ClipboardItem(category: "sql", content: "SELECT * FROM users")
        let data = try JSONEncoder().encode(item)
        let decoded = try JSONDecoder().decode(ClipboardItem.self, from: data)
        #expect(decoded.id       == item.id)
        #expect(decoded.category == item.category)
        #expect(decoded.content  == item.content)
    }

    @Test func codablePreservesCreatedAt() throws {
        let date = Date(timeIntervalSince1970: 1_000_000)
        let item = ClipboardItem(id: UUID(), createdAt: date, category: "", content: "x")
        let data = try JSONEncoder().encode(item)
        let decoded = try JSONDecoder().decode(ClipboardItem.self, from: data)
        #expect(abs(decoded.createdAt.timeIntervalSince(date)) < 0.001)
    }

    @Test func categoryIsMutable() {
        var item = ClipboardItem(category: "old", content: "c")
        item.category = "new"
        #expect(item.category == "new")
    }
}
