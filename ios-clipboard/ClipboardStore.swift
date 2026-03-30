//
//  ClipboardStore.swift
//  ios-clipboard
//

import SwiftUI

enum SortOrder: CaseIterable {
    case registration, category

    func label(_ lang: AppLanguage) -> String {
        switch self {
        case .registration: return lang.t("Date", "登録順")
        case .category:     return lang.t("Category", "カテゴリ順")
        }
    }
}

@Observable
class ClipboardStore {
    private static let saveKey = "clipboard_items"

    private var _items: [ClipboardItem] {
        didSet { save() }
    }

    private var history: [[ClipboardItem]] = []

    init() {
        if let data = UserDefaults.standard.data(forKey: Self.saveKey),
           let saved = try? JSONDecoder().decode([ClipboardItem].self, from: data) {
            _items = saved
        } else {
            _items = [
                ClipboardItem(
                    category: "mail",
                    content: "example@example.com"
                ),
            ]
        }
    }

    private func save() {
        if let data = try? JSONEncoder().encode(_items) {
            UserDefaults.standard.set(data, forKey: Self.saveKey)
        }
    }

    var sortOrder: SortOrder = .registration
    var filterCategory: String? = nil

    static let uncategorized = "__uncategorized__"

    var canUndo: Bool { !history.isEmpty }

    /// フィルタ前の保存件数（無料プランの上限チェックに使用）
    var totalCount: Int { _items.count }

    var categories: [String] {
        var cats = Array(Set(_items.map { $0.category }.filter { !$0.isEmpty })).sorted()
        if _items.contains(where: { $0.category.isEmpty }) {
            cats.append(Self.uncategorized)
        }
        return cats
    }

    var items: [ClipboardItem] {
        let sorted: [ClipboardItem]
        switch sortOrder {
        case .registration:
            sorted = _items.reversed()
        case .category:
            sorted = _items.sorted {
                if $0.category.isEmpty != $1.category.isEmpty {
                    return !$0.category.isEmpty
                }
                return $0.category < $1.category
            }
        }
        guard let filter = filterCategory else { return sorted }
        if filter == Self.uncategorized {
            return sorted.filter { $0.category.isEmpty }
        }
        return sorted.filter { $0.category == filter }
    }

    private func saveHistory() {
        history.append(_items)
    }

    func add(category: String, content: String) {
        saveHistory()
        if let i = _items.firstIndex(where: { $0.content == content }) {
            var updated = _items[i]
            updated.createdAt = Date()
            _items.remove(at: i)
            _items.append(updated)
        } else {
            _items.append(ClipboardItem(category: category, content: content))
        }
    }

    func delete(item: ClipboardItem) {
        saveHistory()
        _items.removeAll { $0.id == item.id }
    }

    func updateCategory(item: ClipboardItem, category: String) {
        saveHistory()
        if let i = _items.firstIndex(where: { $0.id == item.id }) {
            _items[i].category = category
        }
    }

    func reset() {
        saveHistory()
        _items = [
            ClipboardItem(category: "mail", content: "example@example.com")
        ]
    }

    /// アイテムを登録順の先頭（最新）に移動する
    func moveToTop(item: ClipboardItem) {
        saveHistory()
        _items.removeAll { $0.id == item.id }
        _items.append(item)
        sortOrder = .registration
        filterCategory = nil
    }

    func undo() {
        guard let previous = history.popLast() else { return }
        _items = previous
    }
}
