//
//  AppSettings.swift
//  ios-clipboard
//

import SwiftUI

enum AppLanguage: String, CaseIterable {
    case english    = "en"
    case japanese   = "ja"
    case thai       = "th"
    case chinese    = "zh"
    case vietnamese = "vi"

    var displayName: String {
        switch self {
        case .english:    return "English"
        case .japanese:   return "日本語"
        case .thai:       return "ภาษาไทย"
        case .chinese:    return "中文"
        case .vietnamese: return "Tiếng Việt"
        }
    }

    func s(_ key: L) -> String { key.string(self) }
}

@Observable
class AppSettings {
    private static let languageKey    = "app_language"
    private static let colorSchemeKey = "app_color_scheme"

    var language: AppLanguage {
        didSet { UserDefaults.standard.set(language.rawValue, forKey: Self.languageKey) }
    }

    var colorScheme: ColorScheme {
        didSet { UserDefaults.standard.set(colorScheme == .dark, forKey: Self.colorSchemeKey) }
    }

    init() {
        let savedLang = UserDefaults.standard.string(forKey: Self.languageKey)
        language = AppLanguage(rawValue: savedLang ?? "") ?? .english

        let isDark = UserDefaults.standard.bool(forKey: Self.colorSchemeKey)
        colorScheme = isDark ? .dark : .light
    }
}
