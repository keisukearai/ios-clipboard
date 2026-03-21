//
//  PurchaseManager.swift
//  ios-clipboard
//

import StoreKit
import SwiftUI

@Observable
class PurchaseManager {
    // TODO: App Store Connect で登録した製品IDに変更してください
    static let productID = "com.example.ios_clipboard.pro"

    private static let proKey = "is_pro"

    var isPro: Bool {
        didSet { UserDefaults.standard.set(isPro, forKey: Self.proKey) }
    }

    init() {
        isPro = UserDefaults.standard.bool(forKey: Self.proKey)
    }

    /// 起動時に購入状態を復元する
    func restorePurchases() async {
        do {
            try await AppStore.sync()
        } catch {
            // ネットワーク不可など。ローカルキャッシュで続行
        }
        await refreshStatus()
    }

    /// 購入処理
    func purchase() async throws {
        let products = try await Product.products(for: [Self.productID])
        guard let product = products.first else { return }
        let result = try await product.purchase()
        if case .success(let verification) = result,
           case .verified = verification {
            isPro = true
        }
    }

    // MARK: - Private

    private func refreshStatus() async {
        for await result in Transaction.currentEntitlements {
            if case .verified(let tx) = result,
               tx.productID == Self.productID,
               tx.revocationDate == nil {
                isPro = true
                return
            }
        }
    }
}
