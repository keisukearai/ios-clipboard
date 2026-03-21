//
//  AddItemView.swift
//  ios-clipboard
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AppSettings.self) private var settings
    @Environment(ClipboardStore.self) private var store

    @State private var category = ""
    @State private var content = ""

    private var lang: AppLanguage { settings.language }

    private var existingCategories: [String] {
        store.categories.filter { $0 != ClipboardStore.uncategorized }
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(lang.t("Category (optional)", "カテゴリ（任意）")) {
                    TextField(lang.t("e.g. URL, SQL, Email", "例: URL、SQL、メールアドレス"), text: $category)

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

                Section(lang.t("Content", "コピーする内容")) {
                    TextField(lang.t("e.g. https://example.com", "例: https://example.com"), text: $content, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle(lang.t("New Item", "新規追加"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(lang.t("Cancel", "キャンセル")) { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(lang.t("Add", "追加")) {
                        store.add(category: category, content: content)
                        dismiss()
                    }
                    .disabled(content.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddItemView()
        .environment(ClipboardStore())
        .environment(AppSettings())
}
