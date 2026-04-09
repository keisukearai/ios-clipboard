//
//  LocalizationTests.swift
//  ios-clipboardTests
//

import Testing
@testable import ios_clipboard

@Suite("Localization")
struct LocalizationTests {

    private let allLanguages = AppLanguage.allCases

    // MARK: - All keys return non-empty strings

    @Test func allSimpleKeysReturnNonEmptyStrings() {
        let keys: [L] = [
            .cancel, .ok, .save, .close, .delete, .add, .copy, .copyDone,
            .reset, .resetAllData, .resetConfirmMessage,
            .howToUse,
            .lightMode, .darkMode, .language,
            .filter, .all, .noCategory, .sort, .sortByDate, .sortByCategory,
            .copiedHeader, .noneValue,
            .newItem, .categoryOptional, .categoryPlaceholder,
            .content, .contentPlaceholder, .category, .editCategory,
            .actions, .copyButton, .copyButtonDesc,
            .undo, .undoDesc, .newItemDesc,
            .longPress, .moveToTop, .moveToTopDesc, .editCategoryDesc, .deleteDesc,
        ]
        for key in keys {
            for lang in allLanguages {
                #expect(!lang.s(key).isEmpty, "\(key) is empty for \(lang.rawValue)")
            }
        }
    }

    // MARK: - Parametric keys

    // MARK: - Per-language spot checks

    @Test func englishTranslations() {
        let l = AppLanguage.english
        #expect(l.s(.cancel)    == "Cancel")
        #expect(l.s(.ok)        == "OK")
        #expect(l.s(.save)      == "Save")
        #expect(l.s(.close)     == "Close")
        #expect(l.s(.delete)    == "Delete")
        #expect(l.s(.add)       == "Add")
        #expect(l.s(.copy)      == "Copy")
        #expect(l.s(.copyDone)  == "Done")
    }

    @Test func japaneseTranslations() {
        let l = AppLanguage.japanese
        #expect(l.s(.cancel)    == "キャンセル")
        #expect(l.s(.ok)        == "OK")
        #expect(l.s(.save)      == "保存")
        #expect(l.s(.close)     == "閉じる")
        #expect(l.s(.delete)    == "削除")
        #expect(l.s(.add)       == "追加")
        #expect(l.s(.copy)      == "コピー")
        #expect(l.s(.copyDone)  == "済")
    }

    @Test func thaiTranslations() {
        let l = AppLanguage.thai
        #expect(l.s(.cancel)   == "ยกเลิก")
        #expect(l.s(.save)     == "บันทึก")
        #expect(l.s(.close)    == "ปิด")
        #expect(l.s(.delete)   == "ลบ")
        #expect(l.s(.add)      == "เพิ่ม")
    }

    @Test func chineseTranslations() {
        let l = AppLanguage.chinese
        #expect(l.s(.cancel)   == "取消")
        #expect(l.s(.save)     == "保存")
        #expect(l.s(.close)    == "关闭")
        #expect(l.s(.delete)   == "删除")
        #expect(l.s(.add)      == "添加")
    }

    @Test func vietnameseTranslations() {
        let l = AppLanguage.vietnamese
        #expect(l.s(.cancel)   == "Hủy")
        #expect(l.s(.save)     == "Lưu")
        #expect(l.s(.close)    == "Đóng")
        #expect(l.s(.delete)   == "Xóa")
        #expect(l.s(.add)      == "Thêm")
    }

    // MARK: - Translations differ across languages (no accidental copy-paste)

    @Test func cancelTranslationsDifferAcrossLanguages() {
        let values = allLanguages.map { $0.s(.cancel) }
        // At minimum english, japanese and vietnamese should differ
        #expect(values[0] != values[1]) // en != ja
        #expect(values[1] != values[4]) // ja != vi
    }
}
