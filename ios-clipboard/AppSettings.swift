//
//  AppSettings.swift
//  ios-clipboard
//

import SwiftUI

enum AppLanguage: String {
    case english = "en"
    case japanese = "ja"

    func t(_ en: String, _ ja: String) -> String {
        self == .english ? en : ja
    }
}

@Observable
class AppSettings {
    private static let languageKey   = "app_language"
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
