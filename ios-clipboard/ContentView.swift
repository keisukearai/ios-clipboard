//
//  ContentView.swift
//  ios-clipboard
//

import SwiftUI

struct ContentView: View {
    @State private var store = ClipboardStore()
    @State private var settings = AppSettings()
    @State private var purchaseManager = PurchaseManager()
    @State private var showingAddSheet = false
    @State private var showingHelp = false
    @State private var showingResetConfirm = false
    @State private var showingPaywall = false
    @State private var copiedText: String? = nil

    private static let freeLimit = 3
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
            lang.t("Reset all data?", "初期化しますか？"),
            isPresented: $showingResetConfirm,
            titleVisibility: .visible
        ) {
            Button(lang.t("Reset", "初期化"), role: .destructive) {
                store.reset()
            }
            Button(lang.t("Cancel", "キャンセル"), role: .cancel) {}
        } message: {
            Text(lang.t("All items except the initial record will be deleted.", "初期レコード以外のデータをすべて削除します。"))
        }
        .sheet(isPresented: $showingHelp) {
            HelpView().environment(settings)
        }
        .sheet(isPresented: $showingAddSheet) {
            AddItemView().environment(store).environment(settings)
        }
        .alert(
            lang.t("Upgrade to Pro", "Proにアップグレード"),
            isPresented: $showingPaywall
        ) {
            Button(lang.t("Upgrade", "アップグレード")) {
                Task { try? await purchaseManager.purchase() }
            }
            Button(lang.t("Cancel", "キャンセル"), role: .cancel) {}
        } message: {
            Text(lang.t(
                "Free plan allows up to \(Self.freeLimit) items. Upgrade to Pro for unlimited storage.",
                "無料プランは\(Self.freeLimit)件まで保存できます。Proにアップグレードすると無制限に保存できます。"
            ))
        }
        .task { await purchaseManager.restorePurchases() }
        .preferredColorScheme(settings.colorScheme)
        .environment(store)
        .environment(settings)
    }

    // MARK: - Toolbar

    @ToolbarContentBuilder
    private var leadingToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Menu {
                // 購入状態
                if purchaseManager.isPro {
                    Label(lang.t("Pro (Unlimited)", "Pro（無制限）"), systemImage: "star.fill")
                } else {
                    Label(
                        lang.t("Free · \(store.totalCount)/\(Self.freeLimit) items", "無料 · \(store.totalCount)/\(Self.freeLimit)件"),
                        systemImage: "star"
                    )
                }
                Divider()
                Button {
                    showingHelp = true
                } label: {
                    Label(lang.t("How to Use", "使い方"), systemImage: "questionmark.circle")
                }
                Divider()
                Button {
                    settings.colorScheme = settings.colorScheme == .light ? .dark : .light
                } label: {
                    let isDark = settings.colorScheme == .dark
                    Label(
                        isDark ? lang.t("Light Mode", "ライトモード") : lang.t("Dark Mode", "ダークモード"),
                        systemImage: isDark ? "sun.max" : "moon"
                    )
                }
                Button {
                    settings.language = lang == .english ? .japanese : .english
                } label: {
                    Label(
                        lang == .english ? "日本語に切り替え" : "Switch to English",
                        systemImage: "globe"
                    )
                }
                Divider()
                Button(role: .destructive) {
                    showingResetConfirm = true
                } label: {
                    Label(lang.t("Reset", "初期化"), systemImage: "arrow.counterclockwise")
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
            Button { store.undo() } label: {
                Image(systemName: "arrow.uturn.backward")
                    .tileStyle(color: .gray)
            }
            .disabled(!store.canUndo)
            Button {
                if !purchaseManager.isPro && store.totalCount >= Self.freeLimit {
                    showingPaywall = true
                } else {
                    showingAddSheet = true
                }
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
            Section(lang.t("Filter", "フィルター")) {
                Button {
                    store.filterCategory = nil
                } label: {
                    HStack {
                        Text(lang.t("All", "すべて"))
                        if store.filterCategory == nil { Image(systemName: "checkmark") }
                    }
                }
                ForEach(store.categories, id: \.self) { cat in
                    Button {
                        store.filterCategory = cat
                    } label: {
                        HStack {
                            Text(cat == ClipboardStore.uncategorized
                                 ? lang.t("No Category", "未設定") : cat)
                            if store.filterCategory == cat { Image(systemName: "checkmark") }
                        }
                    }
                }
            }
            Section(lang.t("Sort", "並び替え")) {
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

    var body: some View {
        VStack(spacing: 0) {
            Divider()
            VStack(alignment: .leading, spacing: 4) {
                Text(lang.t("Copied", "コピー中の内容"))
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                Text(copiedText ?? lang.t("(none)", "（未コピー）"))
                    .font(.caption)
                    .foregroundStyle(copiedText == nil ? .tertiary : .primary)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
            .background(Color(.systemGray6))
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
