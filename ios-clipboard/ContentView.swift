//
//  ContentView.swift
//  ios-clipboard
//

import SwiftUI

struct ContentView: View {
    @State private var store = ClipboardStore()
    @State private var settings = AppSettings()
    @State private var showingAddSheet = false
    @State private var showingHelp = false
    @State private var showingUndoConfirm = false
    @State private var showingResetConfirm = false
    @State private var showingResetFinalConfirm = false
    @State private var copiedText: String? = nil

    private var lang: AppLanguage { settings.language }

    var body: some View {
        NavigationStack {
            List(store.items) { item in
                ClipboardRowView(item: item, onCopy: { text in
                    copiedText = text
                })
            }
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .contentMargins(.top, 0, for: .scrollContent)
            .toolbar {
                leadingToolbar
                trailingToolbar
            }
            .safeAreaInset(edge: .bottom) {
                CopiedFooterView(copiedText: copiedText, lang: lang)
            }
        }
        .confirmationDialog(
            lang.s(.undo),
            isPresented: $showingUndoConfirm,
            titleVisibility: .visible
        ) {
            Button(lang.s(.undo), role: .destructive) {
                store.undo()
            }
            Button(lang.s(.cancel), role: .cancel) {}
        } message: {
            Text(lang.s(.undoConfirmMessage))
        }
        // 第1確認
        .confirmationDialog(
            lang.s(.resetAllData),
            isPresented: $showingResetConfirm,
            titleVisibility: .visible
        ) {
            Button(lang.s(.reset), role: .destructive) {
                showingResetFinalConfirm = true
            }
            Button(lang.s(.cancel), role: .cancel) {}
        } message: {
            Text(lang.s(.resetConfirmMessage))
        }
        // 第2確認（カスタムシート：初期化ボタンを小さく目立たなくする）
        .sheet(isPresented: $showingResetFinalConfirm) {
            ResetFinalConfirmSheet(lang: lang) {
                store.reset()
            }
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $showingHelp) {
            HelpView().environment(settings)
        }
        .sheet(isPresented: $showingAddSheet) {
            AddItemView().environment(store).environment(settings)
        }
        .preferredColorScheme(settings.colorScheme)
        .environment(store)
        .environment(settings)
    }

    // MARK: - Toolbar

    @ToolbarContentBuilder
    private var leadingToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Menu {
                Button {
                    showingHelp = true
                } label: {
                    Label(lang.s(.howToUse), systemImage: "questionmark.circle")
                }
                Divider()
                Button {
                    settings.colorScheme = settings.colorScheme == .light ? .dark : .light
                } label: {
                    let isDark = settings.colorScheme == .dark
                    Label(
                        isDark ? lang.s(.lightMode) : lang.s(.darkMode),
                        systemImage: isDark ? "sun.max" : "moon"
                    )
                }
                Menu {
                    ForEach(AppLanguage.allCases, id: \.self) { l in
                        Button {
                            settings.language = l
                        } label: {
                            if l == lang {
                                Label(l.displayName, systemImage: "checkmark")
                            } else {
                                Text(l.displayName)
                            }
                        }
                    }
                } label: {
                    Label(lang.s(.language), systemImage: "globe")
                }
                Divider()
                Button(role: .destructive) {
                    showingResetConfirm = true
                } label: {
                    Label(lang.s(.reset), systemImage: "arrow.counterclockwise")
                }
            } label: {
                Image(systemName: "gearshape")
                    .tileStyle(color: .gray)
            }
        }
    }

    @ToolbarContentBuilder
    private var trailingToolbar: some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            FilterSortMenu(store: store, lang: lang)
            Button { showingUndoConfirm = true } label: {
                Image(systemName: "arrow.counterclockwise")
                    .tileStyle(color: .gray)
            }
            .disabled(!store.canUndo)
            Button {
                showingAddSheet = true
            } label: {
                Image(systemName: "plus")
                    .tileStyle(color: .gray)
            }
        }
    }
}

// MARK: - Filter + Sort Menu

private struct FilterSortMenu: View {
    let store: ClipboardStore
    let lang: AppLanguage

    var body: some View {
        Menu {
            Section(lang.s(.filter)) {
                Button {
                    store.filterCategory = nil
                } label: {
                    HStack {
                        Text(lang.s(.all))
                        if store.filterCategory == nil { Image(systemName: "checkmark") }
                    }
                }
                ForEach(store.categories, id: \.self) { cat in
                    Button {
                        store.filterCategory = cat
                    } label: {
                        HStack {
                            Text(cat == ClipboardStore.uncategorized
                                 ? lang.s(.noCategory) : cat)
                            if store.filterCategory == cat { Image(systemName: "checkmark") }
                        }
                    }
                }
            }
            Section(lang.s(.sort)) {
                ForEach(SortOrder.allCases, id: \.self) { order in
                    Button {
                        store.sortOrder = order
                    } label: {
                        HStack {
                            Text(order.label(lang))
                            if store.sortOrder == order { Image(systemName: "checkmark") }
                        }
                    }
                }
            }
        } label: {
            Image(systemName: store.filterCategory == nil
                  ? "line.3.horizontal.decrease.circle"
                  : "line.3.horizontal.decrease.circle.fill")
                .tileStyle(color: store.filterCategory == nil ? .gray : .pink)
        }
    }
}

// MARK: - Copied Footer

private struct CopiedFooterView: View {
    let copiedText: String?
    let lang: AppLanguage
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        VStack(spacing: 0) {
            Divider()
            VStack(alignment: .leading, spacing: 4) {
                Text(lang.s(.copiedHeader))
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                Text(copiedText ?? lang.s(.noneValue))
                    .font(.caption)
                    .foregroundStyle(copiedText == nil ? .tertiary : .primary)
                    .lineLimit(3)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, horizontalSizeClass == .regular ? 24 : 16)
            .padding(.vertical, 6)
            .background(Color(.systemGray6))
        }
    }
}

// MARK: - Reset Final Confirm Sheet

private struct ResetFinalConfirmSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    let lang: AppLanguage
    let onConfirm: () -> Void

    private var isRegularWidth: Bool { horizontalSizeClass == .regular }
    private var hPadding: CGFloat { isRegularWidth ? 64 : 32 }

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 40))
                .foregroundStyle(.orange)
            Text(lang.s(.resetAllData))
                .font(.headline)
                .multilineTextAlignment(.center)
            Text(lang.s(.resetFinalConfirmMessage))
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, hPadding)
            Spacer()
            // キャンセルを大きく・目立つボタンにする
            Button(lang.s(.cancel)) {
                dismiss()
            }
            .font(.body.bold())
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .padding(.horizontal, hPadding)
            // 初期化は小さく・目立たないリンク風ボタン
            Button(lang.s(.reset)) {
                onConfirm()
                dismiss()
            }
            .font(.footnote)
            .foregroundStyle(.red.opacity(0.6))
            .padding(.bottom, 24)
        }
    }
}

// MARK: - Tile Style

private extension View {
    func tileStyle(color: Color) -> some View {
        self
            .font(.system(size: 13, weight: .semibold))
            .foregroundStyle(.white)
            .frame(width: 28, height: 28)
            .background(color, in: RoundedRectangle(cornerRadius: 7))
    }
}

#Preview {
    ContentView()
}
