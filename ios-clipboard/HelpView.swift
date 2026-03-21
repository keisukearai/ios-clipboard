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
                Section(lang.t("Actions", "操作")) {
                    HelpRow(icon: "hand.tap", color: .teal,
                            title: lang.t("Copy Button", "コピーボタン"),
                            desc: lang.t("Copy content to clipboard", "内容をクリップボードにコピー"))
                    HelpRow(icon: "arrow.uturn.backward", color: .gray,
                            title: lang.t("Undo", "↩ ボタン"),
                            desc: lang.t("Undo the last action", "直前の操作を元に戻す"))
                    HelpRow(icon: "plus", color: .gray,
                            title: lang.t("New Item", "新規追加"),
                            desc: lang.t("Add a new clipboard item", "新しいアイテムを追加"))
                }

                // 長押し操作
                Section(lang.t("Long Press on Row", "行を長押し")) {
                    HelpRow(icon: "arrow.up.to.line", color: .blue,
                            title: lang.t("Move to Top", "先頭に移動"),
                            desc: lang.t("Move item to top of list", "一覧の先頭へ移動"))
                    HelpRow(icon: "tag", color: .purple,
                            title: lang.t("Edit Category", "カテゴリを編集"),
                            desc: lang.t("Change the item's category", "カテゴリを変更"))
                    HelpRow(icon: "trash", color: .red,
                            title: lang.t("Delete", "削除"),
                            desc: lang.t("Delete item from list", "一覧から削除"))
                }
            }
            .navigationTitle(lang.t("How to Use", "使い方"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(lang.t("Close", "閉じる")) { dismiss() }
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
