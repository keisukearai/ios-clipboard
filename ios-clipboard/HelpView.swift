//
//  HelpView.swift
//  ios-clipboard
//

import SwiftUI

struct HelpView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AppSettings.self) private var settings

    private var lang: AppLanguage { settings.language }

    var body: some View {
        NavigationStack {
            List {
                // 通常操作
                Section(lang.s(.actions)) {
                    HelpRow(icon: "hand.tap", color: .teal,
                            title: lang.s(.copyButton),
                            desc: lang.s(.copyButtonDesc))
                    HelpRow(icon: "arrow.counterclockwise", color: .gray,
                            title: lang.s(.undo),
                            desc: lang.s(.undoDesc))
                    HelpRow(icon: "plus", color: .gray,
                            title: lang.s(.newItem),
                            desc: lang.s(.newItemDesc))
                }

                // 長押し操作
                Section(lang.s(.longPress)) {
                    HelpRow(icon: "arrow.up.to.line", color: .blue,
                            title: lang.s(.moveToTop),
                            desc: lang.s(.moveToTopDesc))
                    HelpRow(icon: "tag", color: .purple,
                            title: lang.s(.editCategory),
                            desc: lang.s(.editCategoryDesc))
                    HelpRow(icon: "trash", color: .red,
                            title: lang.s(.delete),
                            desc: lang.s(.deleteDesc))
                }
            }
            .navigationTitle(lang.s(.howToUse))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(lang.s(.close)) { dismiss() }
                }
            }
        }
    }
}

private struct HelpRow: View {
    let icon: String
    let color: Color
    let title: String
    let desc: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(.white)
                .frame(width: 32, height: 32)
                .background(color, in: RoundedRectangle(cornerRadius: 7))
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(desc)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    HelpView()
        .environment(AppSettings())
}
