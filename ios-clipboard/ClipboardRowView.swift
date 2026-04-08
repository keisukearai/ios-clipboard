//
//  ClipboardRowView.swift
//  ios-clipboard
//

import SwiftUI

struct ClipboardRowView: View {
    let item: ClipboardItem
    let onCopy: (String) -> Void

    @Environment(AppSettings.self) private var settings
    @Environment(ClipboardStore.self) private var store
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var copied = false
    @State private var showingEditCategory = false

    private var isRegularWidth: Bool { horizontalSizeClass == .regular }

    var body: some View {
        HStack(spacing: 10) {
            // カテゴリラベル
            if !item.category.isEmpty {
                // iPad (regular) では最大8文字、iPhone (compact) では最大4文字
                Text(String(item.category.prefix(isRegularWidth ? 8 : 4)))
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .fixedSize()
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(Color.indigo, in: RoundedRectangle(cornerRadius: 4))
                    .frame(minWidth: 46)
                    // 固定高さを廃止: Dynamic Type 使用時にテキストが縦方向にクリップされるのを防ぐ
            } else {
                Spacer().frame(width: 46)
            }

            // コピー内容（テキストボックス風）
            // 改行をスペースに置換してリスト上でプレビュー表示する
            Text(item.content.replacingOccurrences(of: "\n", with: " "))
                .font(.subheadline)
                .foregroundStyle(.primary)
                .lineLimit(isRegularWidth ? 3 : 2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 8)
                .padding(.vertical, 6)
                .background(Color(.systemGray5))
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color(.systemGray3), lineWidth: 0.33)
                )

            // コピーボタン
            Button {
                UIPasteboard.general.string = item.content
                onCopy(item.content)
                withAnimation(.spring(duration: 0.2)) { copied = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation { copied = false }
                }
            } label: {
                HStack(spacing: 3) {
                    if copied {
                        Image(systemName: "checkmark")
                            .font(.system(size: 10, weight: .bold))
                    }
                    Text(copied ? settings.language.s(.copyDone) : settings.language.s(.copy))
                        .font(.caption)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .frame(minWidth: isRegularWidth ? 80 : 64)
                .background(copied ? Color.orange : Color.teal,
                            in: RoundedRectangle(cornerRadius: 6))
                .animation(.spring(duration: 0.2), value: copied)
            }
            .buttonStyle(.plain)
            .layoutPriority(-1)


        }
        .listRowInsets(EdgeInsets(
            top: isRegularWidth ? 8 : 6,
            leading: isRegularWidth ? 24 : 16,
            bottom: isRegularWidth ? 8 : 6,
            trailing: isRegularWidth ? 24 : 16
        ))
        .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
        .contextMenu {
            Button {
                store.moveToTop(item: item)
            } label: {
                Label(
                    settings.language.s(.moveToTop),
                    systemImage: "arrow.up.to.line"
                )
            }

            Button {
                showingEditCategory = true
            } label: {
                Label(
                    settings.language.s(.editItem),
                    systemImage: "pencil"
                )
            }

            Divider()

            Button(role: .destructive) {
                store.delete(item: item)
            } label: {
                Label(
                    settings.language.s(.delete),
                    systemImage: "trash"
                )
            }
        }
        .sheet(isPresented: $showingEditCategory) {
            EditCategoryView(item: item)
                .environment(store)
                .environment(settings)
        }
    }
}

#Preview {
    List {
        ClipboardRowView(
            item: ClipboardItem(category: "URL", content: "https://example.com/api/v1/users"),
            onCopy: { _ in }
        )
        ClipboardRowView(
            item: ClipboardItem(category: "SQL", content: "SELECT * FROM users WHERE active = 1;"),
            onCopy: { _ in }
        )
    }
    .environment(ClipboardStore())
    .environment(AppSettings())
}
