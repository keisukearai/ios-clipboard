//
//  PurchaseManager.swift
//  ios-clipboard
//

import StoreKit
import SwiftUI

@Observable
class PurchaseManager {
    static let productID = "clipboard.pro"

    private static let proKey = "is_pro"

    var isPro: Bool {
        didSet { UserDefaults.standard.set(isPro, forKey: Self.proKey) }
    }

    /// 購入中フラグ
    var isPurchasing: Bool = false

    /// 購入エラーメッセージ（nilのときはエラーなし）
    var purchaseError: String? = nil

    init() {
        isPro = UserDefaults.standard.bool(forKey: Self.proKey)
    }

    /// 起動時にローカルキャッシュから購入状態を確認する（サインイン不要）
    func checkStatus() async {
        await refreshStatus()
    }

    /// ユーザーが明示的に「購入を復元」を押したときだけ呼ぶ（Apple IDサインインが発生する）
    func restorePurchases() async {
        do {
            try await AppStore.sync()
        } catch {
            // ネットワーク不可など。ローカルキャッシュで続行
        }
        await refreshStatus()
    }

    /// 購入処理
    func purchase() async {
        isPurchasing = true
        purchaseError = nil
        defer { isPurchasing = false }

        do {
            let products = try await Product.products(for: [Self.productID])
            guard let product = products.first else {
                purchaseError = "Purchase is temporarily unavailable. Please try again later."
                return
            }
            let result = try await product.purchase()
            switch result {
            case .success(let verification):
                if case .verified = verification {
                    isPro = true
                } else {
                    purchaseError = "Purchase verification failed. Please contact support."
                }
            case .userCancelled:
                break
            case .pending:
                purchaseError = "Purchase is pending approval."
            @unknown default:
                break
            }
        } catch {
            purchaseError = "Purchase failed: \(error.localizedDescription)"
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
