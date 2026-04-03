//
//  EditCategoryView.swift
//  ios-clipboard
//

import SwiftUI

struct EditCategoryView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AppSettings.self) private var settings
    @Environment(ClipboardStore.self) private var store

    let item: ClipboardItem

    @State private var category: String
    @State private var content: String

    init(item: ClipboardItem) {
        self.item = item
        _category = State(initialValue: item.category)
        _content = State(initialValue: item.content)
    }

    private var lang: AppLanguage { settings.language }

    private var existingCategories: [String] {
        store.categories.filter { $0 != ClipboardStore.uncategorized }
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(lang.s(.category)) {
                    TextField(lang.s(.categoryPlaceholder), text: $category)

                    if !existingCategories.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(existingCategories, id: \.self) { cat in
                                    Button {
                                        category = category == cat ? "" : cat
                                    } label: {
                                        Text(cat)
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(category == cat ? .white : .indigo)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 5)
                                            .background(
                                                category == cat ? Color.indigo : Color.indigo.opacity(0.1),
                                                in: RoundedRectangle(cornerRadius: 4)
                                            )
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }

                Section(lang.s(.content)) {
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $content)
                            .frame(minHeight: 80, maxHeight: 144)
                        if content.isEmpty {
                            Text(lang.s(.contentPlaceholder))
                                .foregroundStyle(Color(.placeholderText))
                                .padding(.top, 8)
                                .padding(.leading, 4)
                                .allowsHitTesting(false)
                        }
                    }
                }
            }
            .navigationTitle(lang.s(.editItem))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(lang.s(.cancel)) { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(lang.s(.save)) {
                        store.updateItem(item: item, category: category, content: content)
                        dismiss()
                    }
                    .disabled(content.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}
