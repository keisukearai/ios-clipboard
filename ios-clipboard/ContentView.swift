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
    @State private var showingPurchaseError = false
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
            lang.s(.resetAllData),
            isPresented: $showingResetConfirm,
            titleVisibility: .visible
        ) {
            Button(lang.s(.reset), role: .destructive) {
                store.reset()
            }
            Button(lang.s(.cancel), role: .cancel) {}
        } message: {
            Text(lang.s(.resetConfirmMessage))
        }
        .sheet(isPresented: $showingHelp) {
            HelpView().environment(settings)
        }
        .sheet(isPresented: $showingAddSheet) {
            AddItemView().environment(store).environment(settings)
        }
        .sheet(isPresented: $showingPaywall) {
            PaywallSheet(
                freeLimit: Self.freeLimit,
                lang: lang,
                purchaseManager: purchaseManager,
                onDismiss: {
                    showingPaywall = false
                    if purchaseManager.purchaseError != nil {
                        showingPurchaseError = true
                    }
                }
            )
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        }
        .alert(
            lang.s(.purchaseUnavailable),
            isPresented: $showingPurchaseError
        ) {
            Button(lang.s(.ok), role: .cancel) {
                purchaseManager.purchaseError = nil
            }
        } message: {
            Text(purchaseManager.purchaseError ?? "")
        }
        .task { await purchaseManager.checkStatus() }
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
                    Label(lang.s(.proUnlimited), systemImage: "star.fill")
                } else {
                    Button {
                        showingPaywall = true
                    } label: {
                        Label(lang.s(.upgradeToPro) + " ✦", systemImage: "star")
                    }
                    Button {
                        Task { await purchaseManager.restorePurchases() }
                    } label: {
                        Label(lang.s(.restorePurchase), systemImage: "arrow.clockwise")
                    }
                }
                Divider()
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
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
            .background(Color(.systemGray6))
        }
    }
}

// MARK: - Paywall Sheet

private struct PaywallSheet: View {
    let freeLimit: Int
    let lang: AppLanguage
    let purchaseManager: PurchaseManager
    let onDismiss: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: "star.circle.fill")
                .font(.system(size: 56))
                .foregroundStyle(.yellow)
            Text(lang.s(.upgradeToPro))
                .font(.title2.bold())
            Text(lang.s(.freeLimitMessage(freeLimit)))
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(.horizontal, 32)
            Spacer()
            VStack(spacing: 12) {
                Button {
                    Task {
                        await purchaseManager.purchase()
                        onDismiss()
                    }
                } label: {
                    Group {
                        if purchaseManager.isPurchasing {
                            ProgressView()
                                .tint(.white)
                        } else {
                            VStack(spacing: 2) {
                                Text(lang.s(.upgradeToPro))
                                    .bold()
                                if let price = purchaseManager.localizedPrice {
                                    Text(lang.s(.priceOneTime(price)))
                                        .font(.caption)
                                        .opacity(0.85)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .disabled(purchaseManager.isPurchasing)
                .padding(.horizontal, 32)

                Button(lang.s(.cancel), role: .cancel) {
                    onDismiss()
                }
                .foregroundStyle(.secondary)
            }
            .padding(.bottom, 32)
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
