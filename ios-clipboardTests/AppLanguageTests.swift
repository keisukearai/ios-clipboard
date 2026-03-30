//
//  AppLanguageTests.swift
//  ios-clipboardTests
//

import Testing
@testable import ios_clipboard

@Suite("AppLanguage")
struct AppLanguageTests {

    @Test func allCasesCountIsFive() {
        #expect(AppLanguage.allCases.count == 5)
    }

    @Test func allDisplayNamesNonEmpty() {
        for lang in AppLanguage.allCases {
            #expect(!lang.displayName.isEmpty, "\(lang.rawValue) has empty displayName")
        }
    }

    @Test func displayNamesAreUnique() {
        let names = AppLanguage.allCases.map { $0.displayName }
        #expect(Set(names).count == names.count)
    }

    @Test func rawValueRoundtrip() {
        for lang in AppLanguage.allCases {
            #expect(AppLanguage(rawValue: lang.rawValue) == lang)
        }
    }

    @Test func unknownRawValueReturnsNil() {
        #expect(AppLanguage(rawValue: "xx") == nil)
    }

    @Test func sHelperMatchesDirectCall() {
        for lang in AppLanguage.allCases {
            #expect(lang.s(.cancel) == L.cancel.string(lang))
        }
    }

    @Test func displayNameForEnglish() {
        #expect(AppLanguage.english.displayName == "English")
    }

    @Test func displayNameForJapanese() {
        #expect(AppLanguage.japanese.displayName == "日本語")
    }

    @Test func displayNameForThai() {
        #expect(AppLanguage.thai.displayName == "ภาษาไทย")
    }

    @Test func displayNameForChinese() {
        #expect(AppLanguage.chinese.displayName == "中文")
    }

    @Test func displayNameForVietnamese() {
        #expect(AppLanguage.vietnamese.displayName == "Tiếng Việt")
    }
}
