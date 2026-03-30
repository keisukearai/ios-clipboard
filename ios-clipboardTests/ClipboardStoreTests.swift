//
//  ClipboardStoreTests.swift
//  ios-clipboardTests
//

import Testing
import Foundation
@testable import ios_clipboard

// ClipboardStore uses UserDefaults.standard. Clear the key before each store
// creation so tests start from a known empty state.
private func makeStore() -> ClipboardStore {
    UserDefaults.standard.removeObject(forKey: "clipboard_items")
    return ClipboardStore()
}

@MainActor
@Suite("ClipboardStore")
struct ClipboardStoreTests {

    // MARK: - Add

    @Test func addNewItemIncreasesCount() {
        let store = makeStore()
        let before = store.totalCount
        store.add(category: "url", content: "https://test.com")
        #expect(store.totalCount == before + 1)
    }

    @Test func addDuplicateContentDoesNotIncreaseCount() {
        let store = makeStore()
        store.add(category: "url", content: "https://dup.com")
        let after = store.totalCount
        store.add(category: "url2", content: "https://dup.com")
        #expect(store.totalCount == after)
    }

    @Test func addDuplicateContentMovesToTop() {
        let store = makeStore()
        store.add(category: "a", content: "first")
        store.add(category: "b", content: "second")
        store.add(category: "c", content: "first") // duplicate
        #expect(store.items.first?.content == "first")
    }

    @Test func addItemAppearsInItems() {
        let store = makeStore()
        store.add(category: "sql", content: "SELECT 1")
        #expect(store.items.contains(where: { $0.content == "SELECT 1" }))
    }

    // MARK: - Delete

    @Test func deleteRemovesItem() {
        let store = makeStore()
        store.add(category: "", content: "to-delete")
        let item = store.items.first { $0.content == "to-delete" }!
        store.delete(item: item)
        #expect(!store.items.contains(where: { $0.id == item.id }))
    }

    @Test func deleteDecreasesCount() {
        let store = makeStore()
        store.add(category: "", content: "del-me")
        let before = store.totalCount
        let item = store.items.first { $0.content == "del-me" }!
        store.delete(item: item)
        #expect(store.totalCount == before - 1)
    }

    // MARK: - Undo

    @Test func canUndoAfterAdd() {
        let store = makeStore()
        store.add(category: "", content: "something")
        #expect(store.canUndo)
    }

    @Test func canUndoAfterDelete() {
        let store = makeStore()
        store.add(category: "", content: "to-delete")
        let item = store.items.first { $0.content == "to-delete" }!
        store.delete(item: item)
        #expect(store.canUndo)
    }

    @Test func canUndoAfterReset() {
        let store = makeStore()
        store.reset()
        #expect(store.canUndo)
    }

    @Test func cannotUndoOnFreshStore() {
        let store = makeStore()
        #expect(!store.canUndo)
    }

    @Test func undoRestoresPreviousState() {
        let store = makeStore()
        let before = store.totalCount
        store.add(category: "", content: "undo-me")
        store.undo()
        #expect(store.totalCount == before)
    }

    @Test func undoMultipleTimes() {
        let store = makeStore()
        let original = store.totalCount
        store.add(category: "", content: "a")
        store.add(category: "", content: "b")
        store.undo()
        store.undo()
        #expect(store.totalCount == original)
    }

    @Test func undoBeyondHistoryIsNoOp() {
        let store = makeStore()
        store.add(category: "", content: "x")
        store.undo()
        let count = store.totalCount
        store.undo() // no-op
        #expect(store.totalCount == count)
        #expect(!store.canUndo)
    }

    // MARK: - Filter

    @Test func filterByCategoryShowsOnlyMatching() {
        let store = makeStore()
        store.add(category: "url", content: "https://a.com")
        store.add(category: "sql", content: "SELECT 1")
        store.filterCategory = "url"
        #expect(store.items.allSatisfy { $0.category == "url" })
    }

    @Test func filterByUncategorizedShowsEmptyCategory() {
        let store = makeStore()
        store.add(category: "", content: "no-cat")
        store.add(category: "url", content: "https://b.com")
        store.filterCategory = ClipboardStore.uncategorized
        #expect(store.items.allSatisfy { $0.category.isEmpty })
    }

    @Test func clearFilterShowsAll() {
        let store = makeStore()
        store.add(category: "url", content: "https://c.com")
        store.add(category: "sql", content: "SELECT 2")
        store.filterCategory = "url"
        store.filterCategory = nil
        #expect(store.items.count == store.totalCount)
    }

    @Test func totalCountIgnoresFilter() {
        let store = makeStore()
        store.add(category: "url", content: "https://d.com")
        store.add(category: "sql", content: "SELECT 3")
        let total = store.totalCount
        store.filterCategory = "url"
        #expect(store.totalCount == total)
    }

    @Test func filterByNonexistentCategoryShowsEmpty() {
        let store = makeStore()
        store.add(category: "url", content: "https://e.com")
        store.filterCategory = "nonexistent"
        #expect(store.items.isEmpty)
    }

    // MARK: - Sort

    @Test func defaultSortIsRegistration() {
        let store = makeStore()
        #expect(store.sortOrder == .registration)
    }

    @Test func sortByRegistrationShowsNewestFirst() {
        let store = makeStore()
        store.add(category: "", content: "older")
        store.add(category: "", content: "newer")
        store.sortOrder = .registration
        #expect(store.items.first?.content == "newer")
    }

    @Test func sortByCategoryGroupsItemsTogether() {
        let store = makeStore()
        store.add(category: "z-cat", content: "z1")
        store.add(category: "a-cat", content: "a1")
        store.add(category: "z-cat", content: "z2")
        store.sortOrder = .category
        let cats = store.items.map { $0.category }
        // sorted order should equal lexically sorted order
        #expect(cats == cats.sorted())
    }

    @Test func sortByCategoryGroupsUncategorizedLast() {
        let store = makeStore()
        store.add(category: "url", content: "categorized")
        store.add(category: "", content: "uncategorized")
        store.sortOrder = .category
        // All categorized items should precede uncategorized items
        #expect(store.items.last?.category == "")
        let firstEmptyIndex = store.items.firstIndex(where: { $0.category.isEmpty })!
        let allBeforeAreNonEmpty = store.items.prefix(firstEmptyIndex).allSatisfy { !$0.category.isEmpty }
        #expect(allBeforeAreNonEmpty)
    }

    // MARK: - MoveToTop

    @Test func moveToTopBringsItemFirst() {
        let store = makeStore()
        store.add(category: "", content: "first-added")
        store.add(category: "", content: "second-added")
        let target = store.items.first { $0.content == "first-added" }!
        store.moveToTop(item: target)
        #expect(store.items.first?.content == "first-added")
    }

    @Test func moveToTopResetsSortOrder() {
        let store = makeStore()
        store.add(category: "url", content: "https://f.com")
        store.sortOrder = .category
        let item = store.items.first!
        store.moveToTop(item: item)
        #expect(store.sortOrder == .registration)
    }

    @Test func moveToTopClearsFilter() {
        let store = makeStore()
        store.add(category: "url", content: "https://g.com")
        store.filterCategory = "url"
        let item = store.items.first!
        store.moveToTop(item: item)
        #expect(store.filterCategory == nil)
    }

    // MARK: - UpdateCategory

    @Test func updateCategoryChangesCategory() {
        let store = makeStore()
        store.add(category: "old", content: "item-to-recategorize")
        let item = store.items.first { $0.content == "item-to-recategorize" }!
        store.updateCategory(item: item, category: "new")
        let updated = store.items.first { $0.id == item.id }
        #expect(updated?.category == "new")
    }

    @Test func updateCategoryIsUndoable() {
        let store = makeStore()
        store.add(category: "old", content: "item")
        // consume history from add
        let item = store.items.first { $0.content == "item" }!
        store.updateCategory(item: item, category: "new")
        store.undo()
        let restored = store.items.first { $0.id == item.id }
        #expect(restored?.category == "old")
    }

    // MARK: - Reset

    @Test func resetLeavesExactlyOneItem() {
        let store = makeStore()
        store.add(category: "", content: "extra1")
        store.add(category: "", content: "extra2")
        store.reset()
        #expect(store.totalCount == 1)
    }

    @Test func resetItemHasSampleEmail() {
        let store = makeStore()
        store.add(category: "", content: "extra")
        store.reset()
        #expect(store.items.first?.content == "example@example.com")
    }

    @Test func resetIsUndoable() {
        let store = makeStore()
        store.add(category: "", content: "extra")
        let before = store.totalCount
        store.reset()
        store.undo()
        #expect(store.totalCount == before)
    }

    // MARK: - Categories

    @Test func categoriesReturnsUniqueValues() {
        let store = makeStore()
        store.add(category: "url", content: "https://h.com")
        store.add(category: "url", content: "https://i.com")
        store.add(category: "sql", content: "SELECT 4")
        let urlCount = store.categories.filter { $0 == "url" }.count
        #expect(urlCount == 1)
    }

    @Test func categoriesExcludesEmptyString() {
        let store = makeStore()
        store.add(category: "", content: "no-category")
        #expect(!store.categories.contains(""))
    }

    @Test func categoriesIncludesUncategorizedSentinelForEmptyCategory() {
        let store = makeStore()
        store.add(category: "", content: "no-category")
        #expect(store.categories.contains(ClipboardStore.uncategorized))
    }

    @Test func categoriesIsSorted() {
        let store = makeStore()
        store.add(category: "z", content: "z-item")
        store.add(category: "a", content: "a-item")
        store.add(category: "m", content: "m-item")
        let cats = store.categories.filter { $0 != ClipboardStore.uncategorized }
        #expect(cats == cats.sorted())
    }
}
