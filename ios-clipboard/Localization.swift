//
//  Localization.swift
//  ios-clipboard
//

// All in-app strings keyed by L, translated for every AppLanguage.
// Add a new case here when adding new UI text; the compiler will flag any
// language that is missing a translation.
enum L {
    // MARK: Common
    case cancel
    case ok
    case save
    case close
    case delete
    case add
    case copy
    case copyDone

    // MARK: Settings menu
    case reset
    case resetAllData
    case resetConfirmMessage
    case proUnlimited
    case upgradeToPro
    case restorePurchase
    case howToUse
    case lightMode
    case darkMode
    case language

    // MARK: Filter / Sort
    case filter
    case all
    case noCategory
    case sort
    case sortByDate
    case sortByCategory

    // MARK: Copied footer
    case copiedHeader
    case noneValue

    // MARK: Paywall
    case purchaseUnavailable
    case freeLimitMessage(Int)
    case priceOneTime(String)

    // MARK: Add / Edit item
    case newItem
    case categoryOptional
    case categoryPlaceholder
    case content
    case contentPlaceholder
    case category
    case editCategory

    // MARK: Help
    case actions
    case copyButton
    case copyButtonDesc
    case undo
    case undoDesc
    case newItemDesc
    case longPress
    case moveToTop
    case moveToTopDesc
    case editCategoryDesc
    case deleteDesc

    // swiftlint:disable:next cyclomatic_complexity function_body_length
    func string(_ lang: AppLanguage) -> String {
        switch self {

        case .cancel:
            switch lang {
            case .english:    return "Cancel"
            case .japanese:   return "キャンセル"
            case .thai:       return "ยกเลิก"
            case .chinese:    return "取消"
            case .vietnamese: return "Hủy"
            }

        case .ok:
            switch lang {
            case .english:    return "OK"
            case .japanese:   return "OK"
            case .thai:       return "ตกลง"
            case .chinese:    return "确定"
            case .vietnamese: return "OK"
            }

        case .save:
            switch lang {
            case .english:    return "Save"
            case .japanese:   return "保存"
            case .thai:       return "บันทึก"
            case .chinese:    return "保存"
            case .vietnamese: return "Lưu"
            }

        case .close:
            switch lang {
            case .english:    return "Close"
            case .japanese:   return "閉じる"
            case .thai:       return "ปิด"
            case .chinese:    return "关闭"
            case .vietnamese: return "Đóng"
            }

        case .delete:
            switch lang {
            case .english:    return "Delete"
            case .japanese:   return "削除"
            case .thai:       return "ลบ"
            case .chinese:    return "删除"
            case .vietnamese: return "Xóa"
            }

        case .add:
            switch lang {
            case .english:    return "Add"
            case .japanese:   return "追加"
            case .thai:       return "เพิ่ม"
            case .chinese:    return "添加"
            case .vietnamese: return "Thêm"
            }

        case .copy:
            switch lang {
            case .english:    return "Copy"
            case .japanese:   return "コピー"
            case .thai:       return "คัดลอก"
            case .chinese:    return "复制"
            case .vietnamese: return "Sao chép"
            }

        case .copyDone:
            switch lang {
            case .english:    return "Done"
            case .japanese:   return "済"
            case .thai:       return "เสร็จ"
            case .chinese:    return "完成"
            case .vietnamese: return "Xong"
            }

        case .reset:
            switch lang {
            case .english:    return "Reset"
            case .japanese:   return "初期化"
            case .thai:       return "รีเซ็ต"
            case .chinese:    return "重置"
            case .vietnamese: return "Đặt lại"
            }

        case .resetAllData:
            switch lang {
            case .english:    return "Reset all data?"
            case .japanese:   return "初期化しますか？"
            case .thai:       return "รีเซ็ตข้อมูลทั้งหมด?"
            case .chinese:    return "重置所有数据？"
            case .vietnamese: return "Đặt lại tất cả dữ liệu?"
            }

        case .resetConfirmMessage:
            switch lang {
            case .english:    return "All items except the initial record will be deleted."
            case .japanese:   return "初期レコード以外のデータをすべて削除します。"
            case .thai:       return "รายการทั้งหมดยกเว้นบันทึกเริ่มต้นจะถูกลบ"
            case .chinese:    return "除初始记录外的所有项目将被删除。"
            case .vietnamese: return "Tất cả mục trừ bản ghi ban đầu sẽ bị xóa."
            }

        case .proUnlimited:
            switch lang {
            case .english:    return "Pro (Unlimited)"
            case .japanese:   return "Pro（無制限）"
            case .thai:       return "Pro (ไม่จำกัด)"
            case .chinese:    return "Pro（无限制）"
            case .vietnamese: return "Pro (Không giới hạn)"
            }

        case .upgradeToPro:
            switch lang {
            case .english:    return "Upgrade to Pro"
            case .japanese:   return "Proにアップグレード"
            case .thai:       return "อัปเกรดเป็น Pro"
            case .chinese:    return "升级到 Pro"
            case .vietnamese: return "Nâng cấp lên Pro"
            }

        case .restorePurchase:
            switch lang {
            case .english:    return "Restore Purchase"
            case .japanese:   return "購入を復元"
            case .thai:       return "กู้คืนการซื้อ"
            case .chinese:    return "恢复购买"
            case .vietnamese: return "Khôi phục mua hàng"
            }

        case .howToUse:
            switch lang {
            case .english:    return "How to Use"
            case .japanese:   return "使い方"
            case .thai:       return "วิธีใช้"
            case .chinese:    return "使用方法"
            case .vietnamese: return "Hướng dẫn"
            }

        case .lightMode:
            switch lang {
            case .english:    return "Light Mode"
            case .japanese:   return "ライトモード"
            case .thai:       return "โหมดสว่าง"
            case .chinese:    return "浅色模式"
            case .vietnamese: return "Chế độ sáng"
            }

        case .darkMode:
            switch lang {
            case .english:    return "Dark Mode"
            case .japanese:   return "ダークモード"
            case .thai:       return "โหมดมืด"
            case .chinese:    return "深色模式"
            case .vietnamese: return "Chế độ tối"
            }

        case .language:
            switch lang {
            case .english:    return "Language"
            case .japanese:   return "言語"
            case .thai:       return "ภาษา"
            case .chinese:    return "语言"
            case .vietnamese: return "Ngôn ngữ"
            }

        case .filter:
            switch lang {
            case .english:    return "Filter"
            case .japanese:   return "フィルター"
            case .thai:       return "กรอง"
            case .chinese:    return "筛选"
            case .vietnamese: return "Lọc"
            }

        case .all:
            switch lang {
            case .english:    return "All"
            case .japanese:   return "すべて"
            case .thai:       return "ทั้งหมด"
            case .chinese:    return "全部"
            case .vietnamese: return "Tất cả"
            }

        case .noCategory:
            switch lang {
            case .english:    return "No Category"
            case .japanese:   return "未設定"
            case .thai:       return "ไม่มีหมวดหมู่"
            case .chinese:    return "无分类"
            case .vietnamese: return "Không có danh mục"
            }

        case .sort:
            switch lang {
            case .english:    return "Sort"
            case .japanese:   return "並び替え"
            case .thai:       return "เรียงลำดับ"
            case .chinese:    return "排序"
            case .vietnamese: return "Sắp xếp"
            }

        case .sortByDate:
            switch lang {
            case .english:    return "Date"
            case .japanese:   return "登録順"
            case .thai:       return "วันที่"
            case .chinese:    return "日期"
            case .vietnamese: return "Ngày"
            }

        case .sortByCategory:
            switch lang {
            case .english:    return "Category"
            case .japanese:   return "カテゴリ順"
            case .thai:       return "หมวดหมู่"
            case .chinese:    return "分类"
            case .vietnamese: return "Danh mục"
            }

        case .copiedHeader:
            switch lang {
            case .english:    return "Copied"
            case .japanese:   return "コピー中の内容"
            case .thai:       return "เนื้อหาที่คัดลอก"
            case .chinese:    return "已复制内容"
            case .vietnamese: return "Nội dung đã sao chép"
            }

        case .noneValue:
            switch lang {
            case .english:    return "(none)"
            case .japanese:   return "（未コピー）"
            case .thai:       return "(ว่าง)"
            case .chinese:    return "（无）"
            case .vietnamese: return "(trống)"
            }

        case .purchaseUnavailable:
            switch lang {
            case .english:    return "Purchase Unavailable"
            case .japanese:   return "購入できませんでした"
            case .thai:       return "ไม่สามารถซื้อได้"
            case .chinese:    return "购买失败"
            case .vietnamese: return "Không thể mua"
            }

        case .freeLimitMessage(let n):
            switch lang {
            case .english:    return "Free plan allows up to \(n) items. Upgrade to Pro for unlimited storage."
            case .japanese:   return "無料プランは\(n)件まで保存できます。Proにアップグレードすると無制限に保存できます。"
            case .thai:       return "แผนฟรีรองรับสูงสุด \(n) รายการ อัปเกรดเป็น Pro เพื่อเก็บข้อมูลไม่จำกัด"
            case .chinese:    return "免费版最多保存 \(n) 条。升级到 Pro 可无限保存。"
            case .vietnamese: return "Gói miễn phí tối đa \(n) mục. Nâng cấp lên Pro để lưu trữ không giới hạn."
            }

        case .priceOneTime(let price):
            switch lang {
            case .english:    return "\(price) one-time purchase"
            case .japanese:   return "\(price) 買い切り"
            case .thai:       return "ซื้อครั้งเดียว \(price)"
            case .chinese:    return "\(price) 一次性购买"
            case .vietnamese: return "Mua một lần \(price)"
            }

        case .newItem:
            switch lang {
            case .english:    return "New Item"
            case .japanese:   return "新規追加"
            case .thai:       return "รายการใหม่"
            case .chinese:    return "新建"
            case .vietnamese: return "Mục mới"
            }

        case .categoryOptional:
            switch lang {
            case .english:    return "Category (optional)"
            case .japanese:   return "カテゴリ（任意）"
            case .thai:       return "หมวดหมู่ (ไม่บังคับ)"
            case .chinese:    return "分类（可选）"
            case .vietnamese: return "Danh mục (tuỳ chọn)"
            }

        case .categoryPlaceholder:
            switch lang {
            case .english:    return "e.g. URL, SQL, Email"
            case .japanese:   return "例: URL、SQL、メールアドレス"
            case .thai:       return "เช่น URL, SQL, อีเมล"
            case .chinese:    return "例如 URL、SQL、邮箱"
            case .vietnamese: return "Ví dụ: URL, SQL, Email"
            }

        case .content:
            switch lang {
            case .english:    return "Content"
            case .japanese:   return "コピーする内容"
            case .thai:       return "เนื้อหาที่จะคัดลอก"
            case .chinese:    return "复制内容"
            case .vietnamese: return "Nội dung sao chép"
            }

        case .contentPlaceholder:
            switch lang {
            case .english:    return "e.g. https://example.com"
            case .japanese:   return "例: https://example.com"
            case .thai:       return "เช่น https://example.com"
            case .chinese:    return "例如 https://example.com"
            case .vietnamese: return "Ví dụ: https://example.com"
            }

        case .category:
            switch lang {
            case .english:    return "Category"
            case .japanese:   return "カテゴリ"
            case .thai:       return "หมวดหมู่"
            case .chinese:    return "分类"
            case .vietnamese: return "Danh mục"
            }

        case .editCategory:
            switch lang {
            case .english:    return "Edit Category"
            case .japanese:   return "カテゴリを編集"
            case .thai:       return "แก้ไขหมวดหมู่"
            case .chinese:    return "编辑分类"
            case .vietnamese: return "Chỉnh sửa danh mục"
            }

        case .actions:
            switch lang {
            case .english:    return "Actions"
            case .japanese:   return "操作"
            case .thai:       return "การกระทำ"
            case .chinese:    return "操作"
            case .vietnamese: return "Thao tác"
            }

        case .copyButton:
            switch lang {
            case .english:    return "Copy Button"
            case .japanese:   return "コピーボタン"
            case .thai:       return "ปุ่มคัดลอก"
            case .chinese:    return "复制按钮"
            case .vietnamese: return "Nút sao chép"
            }

        case .copyButtonDesc:
            switch lang {
            case .english:    return "Copy content to clipboard"
            case .japanese:   return "内容をクリップボードにコピー"
            case .thai:       return "คัดลอกเนื้อหาไปยังคลิปบอร์ด"
            case .chinese:    return "将内容复制到剪贴板"
            case .vietnamese: return "Sao chép nội dung vào clipboard"
            }

        case .undo:
            switch lang {
            case .english:    return "Undo"
            case .japanese:   return "↩ ボタン"
            case .thai:       return "ปุ่ม ↩"
            case .chinese:    return "↩ 按钮"
            case .vietnamese: return "Nút ↩"
            }

        case .undoDesc:
            switch lang {
            case .english:    return "Undo the last action"
            case .japanese:   return "直前の操作を元に戻す"
            case .thai:       return "เลิกทำการกระทำล่าสุด"
            case .chinese:    return "撤销上一步操作"
            case .vietnamese: return "Hoàn tác thao tác vừa rồi"
            }

        case .newItemDesc:
            switch lang {
            case .english:    return "Add a new clipboard item"
            case .japanese:   return "新しいアイテムを追加"
            case .thai:       return "เพิ่มรายการใหม่"
            case .chinese:    return "添加新项目"
            case .vietnamese: return "Thêm mục clipboard mới"
            }

        case .longPress:
            switch lang {
            case .english:    return "Long Press on Row"
            case .japanese:   return "行を長押し"
            case .thai:       return "กดค้างที่แถว"
            case .chinese:    return "长按行"
            case .vietnamese: return "Giữ lâu trên hàng"
            }

        case .moveToTop:
            switch lang {
            case .english:    return "Move to Top"
            case .japanese:   return "先頭に移動"
            case .thai:       return "ย้ายไปด้านบน"
            case .chinese:    return "移到顶部"
            case .vietnamese: return "Di chuyển lên đầu"
            }

        case .moveToTopDesc:
            switch lang {
            case .english:    return "Move item to top of list"
            case .japanese:   return "一覧の先頭へ移動"
            case .thai:       return "ย้ายรายการไปด้านบนของรายการ"
            case .chinese:    return "将项目移到列表顶部"
            case .vietnamese: return "Di chuyển mục lên đầu danh sách"
            }

        case .editCategoryDesc:
            switch lang {
            case .english:    return "Change the item's category"
            case .japanese:   return "カテゴリを変更"
            case .thai:       return "เปลี่ยนหมวดหมู่ของรายการ"
            case .chinese:    return "更改项目分类"
            case .vietnamese: return "Thay đổi danh mục của mục"
            }

        case .deleteDesc:
            switch lang {
            case .english:    return "Delete item from list"
            case .japanese:   return "一覧から削除"
            case .thai:       return "ลบรายการออกจากรายการ"
            case .chinese:    return "从列表中删除"
            case .vietnamese: return "Xóa mục khỏi danh sách"
            }
        }
    }
}
