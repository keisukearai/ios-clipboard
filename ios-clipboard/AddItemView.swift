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
                Section(lang.s(.categoryOptional)) {
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
                    // TextField(axis: .vertical) + lineLimit(range) は日本語 IME 変換中に
                    // ビュー再描画が走り変換候補が消えるため TextEditor に変更
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
            .navigationTitle(lang.s(.newItem))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(lang.s(.cancel)) { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(lang.s(.add)) {
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
