//
//  SortOrderTests.swift
//  ios-clipboardTests
//

import Testing
@testable import ios_clipboard

@Suite("SortOrder")
struct SortOrderTests {

    @Test func allCasesCountIsTwo() {
        #expect(SortOrder.allCases.count == 2)
    }

    @Test func labelIsNonEmptyForAllLanguages() {
        for order in SortOrder.allCases {
            for lang in AppLanguage.allCases {
                #expect(!order.label(lang).isEmpty,
                        "\(order) label empty for \(lang.rawValue)")
            }
        }
    }

    @Test func registrationLabelInEnglish() {
        #expect(SortOrder.registration.label(.english) == "Date")
    }

    @Test func categoryLabelInEnglish() {
        #expect(SortOrder.category.label(.english) == "Category")
    }

    @Test func registrationLabelInJapanese() {
        #expect(SortOrder.registration.label(.japanese) == "登録順")
    }

    @Test func categoryLabelInJapanese() {
        #expect(SortOrder.category.label(.japanese) == "カテゴリ順")
    }

    @Test func labelsAreDifferentForSameLanguage() {
        for lang in AppLanguage.allCases {
            #expect(SortOrder.registration.label(lang) != SortOrder.category.label(lang))
        }
    }
}
