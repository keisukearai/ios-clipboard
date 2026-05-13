//
//  ClipboardStore.swift
//  ios-clipboard
//

import SwiftUI

enum SortOrder: CaseIterable {
    case registration, category

    func label(_ lang: AppLanguage) -> String {
        switch self {
        case .registration: return lang.s(.sortByDate)
        case .category:     return lang.s(.sortByCategory)
        }
    }
}

@Observable
class ClipboardStore {
    private static let saveKey     = "clipboard_items"
    private static let colorMapKey = "clipboard_category_color_map"

    private var _items: [ClipboardItem] {
        didSet { save() }
    }

    // カテゴリ名 → パレットインデックス（永続化）
    private var categoryColorMap: [String: Int] = [:]

    private var history: [[ClipboardItem]] = []

    init() {
        if let data = UserDefaults.standard.data(forKey: Self.saveKey),
           let saved = try? JSONDecoder().decode([ClipboardItem].self, from: data) {
            _items = saved
        } else {
            _items = [ClipboardItem(category: "mail", content: "example@example.com")]
        }

        if let data = UserDefaults.standard.data(forKey: Self.colorMapKey),
           let saved = try? JSONDecoder().decode([String: Int].self, from: data) {
            categoryColorMap = saved
        }

        // 既存カテゴリで未割り当てのものに色を付与
        let existingCats = Set(_items.map { $0.category }.filter { !$0.isEmpty })
        for cat in existingCats.sorted() {
            if categoryColorMap[cat] == nil {
                let next = (categoryColorMap.values.max() ?? -1) + 1
                categoryColorMap[cat] = next % Self.categoryPalette.count
            }
        }
        saveColorMap()
    }

    private func save() {
        if let data = try? JSONEncoder().encode(_items) {
            UserDefaults.standard.set(data, forKey: Self.saveKey)
        }
    }

    private func saveColorMap() {
        if let data = try? JSONEncoder().encode(categoryColorMap) {
            UserDefaults.standard.set(data, forKey: Self.colorMapKey)
        }
    }

    // 新カテゴリが来たときだけ色を割り当て（既存は変更しない）
    private func ensureColor(for category: String) {
        guard !category.isEmpty, category != Self.uncategorized else { return }
        guard categoryColorMap[category] == nil else { return }
        let next = (categoryColorMap.values.max() ?? -1) + 1
        categoryColorMap[category] = next % Self.categoryPalette.count
        saveColorMap()
    }

    var sortOrder: SortOrder = .registration
    var filterCategory: String? = nil

    static let uncategorized = "__uncategorized__"

    static let categoryPalette: [Color] = [
        .indigo, .purple, .pink, .red, .green,
        .blue, .brown, .mint, .cyan, .yellow
    ]

    var canUndo: Bool { !history.isEmpty }

    /// フィルタ前の保存件数（無料プランの上限チェックに使用）
    var totalCount: Int { _items.count }

    var categories: [String] {
        let counts = _items.reduce(into: [String: Int]()) { dict, item in
            if !item.category.isEmpty { dict[item.category, default: 0] += 1 }
        }
        let sorted = counts.keys.sorted {
            counts[$0, default: 0] > counts[$1, default: 0] ||
            (counts[$0, default: 0] == counts[$1, default: 0] && $0 < $1)
        }
        var result = sorted
        if _items.contains(where: { $0.category.isEmpty }) {
            result.append(Self.uncategorized)
        }
        return result
    }

    func color(for category: String) -> Color {
        guard !category.isEmpty, category != Self.uncategorized else {
            return Color(.systemGray)
        }
        let index = categoryColorMap[category] ?? 0
        return Self.categoryPalette[index % Self.categoryPalette.count]
    }

    func count(for category: String) -> Int {
        if category == Self.uncategorized {
            return _items.filter { $0.category.isEmpty }.count
        }
        return _items.filter { $0.category == category }.count
    }

    var items: [ClipboardItem] {
        let sorted: [ClipboardItem]
        switch sortOrder {
        case .registration:
            sorted = _items.reversed()
        case .category:
            let counts = _items.reduce(into: [String: Int]()) { dict, item in
                if !item.category.isEmpty { dict[item.category, default: 0] += 1 }
            }
            sorted = _items.sorted {
                let c0 = $0.category, c1 = $1.category
                if c0 == c1 { return false }
                if c0.isEmpty { return false }
                if c1.isEmpty { return true }
                let n0 = counts[c0, default: 0], n1 = counts[c1, default: 0]
                return n0 != n1 ? n0 > n1 : c0 < c1
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
        ensureColor(for: category)
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
        ensureColor(for: category)
        if let i = _items.firstIndex(where: { $0.id == item.id }) {
            _items[i].category = category
        }
    }

    func updateItem(item: ClipboardItem, category: String, content: String) {
        saveHistory()
        ensureColor(for: category)
        if let i = _items.firstIndex(where: { $0.id == item.id }) {
            _items[i].category = category
            _items[i].content = content
        }
    }

    func reset() {
        saveHistory()
        _items = [ClipboardItem(category: "mail", content: "example@example.com")]
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
