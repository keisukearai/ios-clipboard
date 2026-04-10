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
    case resetFinalConfirmMessage
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

    // MARK: Add / Edit item
    case newItem
    case categoryOptional
    case categoryPlaceholder
    case content
    case contentPlaceholder
    case category
    case editCategory
    case editItem

    // MARK: Help
    case actions
    case copyButton
    case copyButtonDesc
    case undo
    case undoDesc
    case undoConfirmMessage
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
            case .french:     return "Annuler"
            case .spanish:    return "Cancelar"
            case .portuguese: return "Cancelar"
            case .german:     return "Abbruch"
            case .hindi:      return "रद्द"
            }

        case .ok:
            switch lang {
            case .english:    return "OK"
            case .japanese:   return "OK"
            case .thai:       return "ตกลง"
            case .chinese:    return "确定"
            case .vietnamese: return "OK"
            case .french:     return "OK"
            case .spanish:    return "OK"
            case .portuguese: return "OK"
            case .german:     return "OK"
            case .hindi:      return "ठीक"
            }

        case .save:
            switch lang {
            case .english:    return "Save"
            case .japanese:   return "保存"
            case .thai:       return "บันทึก"
            case .chinese:    return "保存"
            case .vietnamese: return "Lưu"
            case .french:     return "Enreg."
            case .spanish:    return "Guardar"
            case .portuguese: return "Salvar"
            case .german:     return "Sichern"
            case .hindi:      return "सेव"
            }

        case .close:
            switch lang {
            case .english:    return "Close"
            case .japanese:   return "閉じる"
            case .thai:       return "ปิด"
            case .chinese:    return "关闭"
            case .vietnamese: return "Đóng"
            case .french:     return "Fermer"
            case .spanish:    return "Cerrar"
            case .portuguese: return "Fechar"
            case .german:     return "Schließen"
            case .hindi:      return "बंद"
            }

        case .delete:
            switch lang {
            case .english:    return "Delete"
            case .japanese:   return "削除"
            case .thai:       return "ลบ"
            case .chinese:    return "删除"
            case .vietnamese: return "Xóa"
            case .french:     return "Suppr."
            case .spanish:    return "Borrar"
            case .portuguese: return "Excluir"
            case .german:     return "Löschen"
            case .hindi:      return "हटाएं"
            }

        case .add:
            switch lang {
            case .english:    return "Add"
            case .japanese:   return "追加"
            case .thai:       return "เพิ่ม"
            case .chinese:    return "添加"
            case .vietnamese: return "Thêm"
            case .french:     return "Ajouter"
            case .spanish:    return "Añadir"
            case .portuguese: return "Adicionar"
            case .german:     return "Hinzufüg."
            case .hindi:      return "जोड़ें"
            }

        case .copy:
            switch lang {
            case .english:    return "Copy"
            case .japanese:   return "コピー"
            case .thai:       return "ก๊อป"
            case .chinese:    return "复制"
            case .vietnamese: return "Chép"
            case .french:     return "Copier"
            case .spanish:    return "Copiar"
            case .portuguese: return "Copiar"
            case .german:     return "Copy"
            case .hindi:      return "कॉपी"
            }

        case .copyDone:
            switch lang {
            case .english:    return "Done"
            case .japanese:   return "済"
            case .thai:       return "เสร็จ"
            case .chinese:    return "完成"
            case .vietnamese: return "Xong"
            case .french:     return "Fait"
            case .spanish:    return "Listo"
            case .portuguese: return "Feito"
            case .german:     return "Fertig"
            case .hindi:      return "हो गया"
            }

        case .reset:
            switch lang {
            case .english:    return "Reset"
            case .japanese:   return "初期化"
            case .thai:       return "ล้าง"
            case .chinese:    return "重置"
            case .vietnamese: return "Xóa"
            case .french:     return "Réinit."
            case .spanish:    return "Reiniciar"
            case .portuguese: return "Redefinir"
            case .german:     return "Reset"
            case .hindi:      return "रीसेट"
            }

        case .resetAllData:
            switch lang {
            case .english:    return "Reset all data?"
            case .japanese:   return "初期化しますか？"
            case .thai:       return "ล้างข้อมูล?"
            case .chinese:    return "重置所有数据？"
            case .vietnamese: return "Xóa hết dữ liệu?"
            case .french:     return "Réinit. tout?"
            case .spanish:    return "¿Reiniciar todo?"
            case .portuguese: return "Redefinir tudo?"
            case .german:     return "Alles löschen?"
            case .hindi:      return "सब रीसेट?"
            }

        case .resetConfirmMessage:
            switch lang {
            case .english:    return "All items except the initial record will be deleted."
            case .japanese:   return "初期レコード以外のデータをすべて削除します。"
            case .thai:       return "ข้อมูลทั้งหมดจะถูกลบ"
            case .chinese:    return "除初始记录外的所有项目将被删除。"
            case .vietnamese: return "Dữ liệu sẽ bị xóa hết."
            case .french:     return "Tous les éléments seront supprimés."
            case .spanish:    return "Todos los datos serán eliminados."
            case .portuguese: return "Todos os dados serão excluídos."
            case .german:     return "Alle Daten werden gelöscht."
            case .hindi:      return "सभी डेटा हटा दिया जाएगा।"
            }

        case .resetFinalConfirmMessage:
            switch lang {
            case .english:    return "This cannot be undone. Are you absolutely sure?"
            case .japanese:   return "この操作は元に戻せません。本当によろしいですか？"
            case .thai:       return "ยืนยัน? ย้อนกลับไม่ได้"
            case .chinese:    return "此操作无法撤销。您确定要继续吗？"
            case .vietnamese: return "Không thể hoàn tác. Chắc chắn?"
            case .french:     return "Irréversible. Confirmer?"
            case .spanish:    return "Irreversible. ¿Seguro?"
            case .portuguese: return "Irreversível. Confirmar?"
            case .german:     return "Unwiderruflich. Sicher?"
            case .hindi:      return "पूर्ववत नहीं। पक्का?"
            }

        case .howToUse:
            switch lang {
            case .english:    return "How to Use"
            case .japanese:   return "使い方"
            case .thai:       return "วิธีใช้"
            case .chinese:    return "使用方法"
            case .vietnamese: return "Hướng dẫn"
            case .french:     return "Guide"
            case .spanish:    return "Guía"
            case .portuguese: return "Guia"
            case .german:     return "Anleitung"
            case .hindi:      return "गाइड"
            }

        case .lightMode:
            switch lang {
            case .english:    return "Light Mode"
            case .japanese:   return "ライトモード"
            case .thai:       return "สว่าง"
            case .chinese:    return "浅色模式"
            case .vietnamese: return "Sáng"
            case .french:     return "Clair"
            case .spanish:    return "Claro"
            case .portuguese: return "Claro"
            case .german:     return "Hell"
            case .hindi:      return "लाइट"
            }

        case .darkMode:
            switch lang {
            case .english:    return "Dark Mode"
            case .japanese:   return "ダークモード"
            case .thai:       return "มืด"
            case .chinese:    return "深色模式"
            case .vietnamese: return "Tối"
            case .french:     return "Sombre"
            case .spanish:    return "Oscuro"
            case .portuguese: return "Escuro"
            case .german:     return "Dunkel"
            case .hindi:      return "डार्क"
            }

        case .language:
            switch lang {
            case .english:    return "Language"
            case .japanese:   return "言語"
            case .thai:       return "ภาษา"
            case .chinese:    return "语言"
            case .vietnamese: return "Ngôn ngữ"
            case .french:     return "Langue"
            case .spanish:    return "Idioma"
            case .portuguese: return "Idioma"
            case .german:     return "Sprache"
            case .hindi:      return "भाषा"
            }

        case .filter:
            switch lang {
            case .english:    return "Filter"
            case .japanese:   return "フィルター"
            case .thai:       return "กรอง"
            case .chinese:    return "筛选"
            case .vietnamese: return "Lọc"
            case .french:     return "Filtrer"
            case .spanish:    return "Filtrar"
            case .portuguese: return "Filtrar"
            case .german:     return "Filtern"
            case .hindi:      return "फ़िल्टर"
            }

        case .all:
            switch lang {
            case .english:    return "All"
            case .japanese:   return "すべて"
            case .thai:       return "ทั้งหมด"
            case .chinese:    return "全部"
            case .vietnamese: return "Tất cả"
            case .french:     return "Tout"
            case .spanish:    return "Todo"
            case .portuguese: return "Tudo"
            case .german:     return "Alle"
            case .hindi:      return "सभी"
            }

        case .noCategory:
            switch lang {
            case .english:    return "No Category"
            case .japanese:   return "未設定"
            case .thai:       return "ไม่มีหมวด"
            case .chinese:    return "无分类"
            case .vietnamese: return "Không mục"
            case .french:     return "Sans cat."
            case .spanish:    return "Sin cat."
            case .portuguese: return "Sem cat."
            case .german:     return "Ohne Kat."
            case .hindi:      return "बिना वर्ग"
            }

        case .sort:
            switch lang {
            case .english:    return "Sort"
            case .japanese:   return "並び替え"
            case .thai:       return "เรียง"
            case .chinese:    return "排序"
            case .vietnamese: return "Xếp"
            case .french:     return "Trier"
            case .spanish:    return "Ordenar"
            case .portuguese: return "Ordenar"
            case .german:     return "Sortieren"
            case .hindi:      return "क्रम"
            }

        case .sortByDate:
            switch lang {
            case .english:    return "Date"
            case .japanese:   return "登録順"
            case .thai:       return "วันที่"
            case .chinese:    return "日期"
            case .vietnamese: return "Ngày"
            case .french:     return "Date"
            case .spanish:    return "Fecha"
            case .portuguese: return "Data"
            case .german:     return "Datum"
            case .hindi:      return "तारीख"
            }

        case .sortByCategory:
            switch lang {
            case .english:    return "Category"
            case .japanese:   return "カテゴリ順"
            case .thai:       return "หมวด"
            case .chinese:    return "分类"
            case .vietnamese: return "Mục"
            case .french:     return "Catégorie"
            case .spanish:    return "Categoría"
            case .portuguese: return "Categoria"
            case .german:     return "Kategorie"
            case .hindi:      return "वर्ग"
            }

        case .copiedHeader:
            switch lang {
            case .english:    return "Copied"
            case .japanese:   return "コピー中の内容"
            case .thai:       return "ที่ก๊อป"
            case .chinese:    return "已复制内容"
            case .vietnamese: return "Đã chép"
            case .french:     return "Copié"
            case .spanish:    return "Copiado"
            case .portuguese: return "Copiado"
            case .german:     return "Kopiert"
            case .hindi:      return "कॉपी किया"
            }

        case .noneValue:
            switch lang {
            case .english:    return "(none)"
            case .japanese:   return "（未コピー）"
            case .thai:       return "(ว่าง)"
            case .chinese:    return "（无）"
            case .vietnamese: return "(trống)"
            case .french:     return "(vide)"
            case .spanish:    return "(ninguno)"
            case .portuguese: return "(nenhum)"
            case .german:     return "(leer)"
            case .hindi:      return "(खाली)"
            }

        case .newItem:
            switch lang {
            case .english:    return "New Item"
            case .japanese:   return "新規追加"
            case .thai:       return "รายการใหม่"
            case .chinese:    return "新建"
            case .vietnamese: return "Mục mới"
            case .french:     return "Nouveau"
            case .spanish:    return "Nuevo"
            case .portuguese: return "Novo"
            case .german:     return "Neu"
            case .hindi:      return "नई आइटम"
            }

        case .categoryOptional:
            switch lang {
            case .english:    return "Category (optional)"
            case .japanese:   return "カテゴリ（任意）"
            case .thai:       return "หมวด (ไม่บังคับ)"
            case .chinese:    return "分类（可选）"
            case .vietnamese: return "Mục (tuỳ chọn)"
            case .french:     return "Catégorie (optionnel)"
            case .spanish:    return "Categoría (opcional)"
            case .portuguese: return "Categoria (opcional)"
            case .german:     return "Kategorie (opt.)"
            case .hindi:      return "वर्ग (वैकल्पिक)"
            }

        case .categoryPlaceholder:
            switch lang {
            case .english:    return "e.g. URL, SQL, Email"
            case .japanese:   return "例: URL、SQL、メールアドレス"
            case .thai:       return "URL, SQL, อีเมล"
            case .chinese:    return "例如 URL、SQL、邮箱"
            case .vietnamese: return "URL, SQL, Email"
            case .french:     return "URL, SQL, Email"
            case .spanish:    return "URL, SQL, Email"
            case .portuguese: return "URL, SQL, Email"
            case .german:     return "URL, SQL, Email"
            case .hindi:      return "URL, SQL, Email"
            }

        case .content:
            switch lang {
            case .english:    return "Content"
            case .japanese:   return "コピーする内容"
            case .thai:       return "เนื้อหา"
            case .chinese:    return "复制内容"
            case .vietnamese: return "Nội dung"
            case .french:     return "Contenu"
            case .spanish:    return "Contenido"
            case .portuguese: return "Conteúdo"
            case .german:     return "Inhalt"
            case .hindi:      return "सामग्री"
            }

        case .contentPlaceholder:
            switch lang {
            case .english:    return "e.g. https://example.com"
            case .japanese:   return "例: https://example.com"
            case .thai:       return "https://example.com"
            case .chinese:    return "例如 https://example.com"
            case .vietnamese: return "https://example.com"
            case .french:     return "ex. https://example.com"
            case .spanish:    return "ej. https://example.com"
            case .portuguese: return "ex. https://example.com"
            case .german:     return "z.B. https://example.com"
            case .hindi:      return "https://example.com"
            }

        case .category:
            switch lang {
            case .english:    return "Category"
            case .japanese:   return "カテゴリ"
            case .thai:       return "หมวด"
            case .chinese:    return "分类"
            case .vietnamese: return "Mục"
            case .french:     return "Catégorie"
            case .spanish:    return "Categoría"
            case .portuguese: return "Categoria"
            case .german:     return "Kategorie"
            case .hindi:      return "वर्ग"
            }

        case .editCategory:
            switch lang {
            case .english:    return "Edit Category"
            case .japanese:   return "カテゴリを編集"
            case .thai:       return "แก้ไขหมวด"
            case .chinese:    return "编辑分类"
            case .vietnamese: return "Sửa mục"
            case .french:     return "Édit. cat."
            case .spanish:    return "Editar cat."
            case .portuguese: return "Editar cat."
            case .german:     return "Kat. bearb."
            case .hindi:      return "वर्ग संपादित"
            }

        case .editItem:
            switch lang {
            case .english:    return "Edit"
            case .japanese:   return "編集"
            case .thai:       return "แก้ไข"
            case .chinese:    return "编辑"
            case .vietnamese: return "Sửa"
            case .french:     return "Modifier"
            case .spanish:    return "Editar"
            case .portuguese: return "Editar"
            case .german:     return "Bearb."
            case .hindi:      return "संपादित"
            }

        case .actions:
            switch lang {
            case .english:    return "Actions"
            case .japanese:   return "操作"
            case .thai:       return "เมนู"
            case .chinese:    return "操作"
            case .vietnamese: return "Thao tác"
            case .french:     return "Actions"
            case .spanish:    return "Acciones"
            case .portuguese: return "Ações"
            case .german:     return "Aktionen"
            case .hindi:      return "क्रियाएं"
            }

        case .copyButton:
            switch lang {
            case .english:    return "Copy Button"
            case .japanese:   return "コピーボタン"
            case .thai:       return "ปุ่มก๊อป"
            case .chinese:    return "复制按钮"
            case .vietnamese: return "Nút chép"
            case .french:     return "Bouton copier"
            case .spanish:    return "Botón copiar"
            case .portuguese: return "Botão copiar"
            case .german:     return "Copy Button"
            case .hindi:      return "कॉपी बटन"
            }

        case .copyButtonDesc:
            switch lang {
            case .english:    return "Copy content to clipboard"
            case .japanese:   return "内容をクリップボードにコピー"
            case .thai:       return "คัดลอกเนื้อหา"
            case .chinese:    return "将内容复制到剪贴板"
            case .vietnamese: return "Chép vào clipboard"
            case .french:     return "Copier dans presse-papiers"
            case .spanish:    return "Copiar al portapapeles"
            case .portuguese: return "Copiar para clipboard"
            case .german:     return "In Zwischenablage"
            case .hindi:      return "क्लिपबोर्ड में कॉपी"
            }

        case .undo:
            switch lang {
            case .english:    return "Undo"
            case .japanese:   return "元に戻す"
            case .thai:       return "ย้อน"
            case .chinese:    return "撤销"
            case .vietnamese: return "Hoàn tác"
            case .french:     return "Annuler"
            case .spanish:    return "Deshacer"
            case .portuguese: return "Desfazer"
            case .german:     return "Rückgängig"
            case .hindi:      return "पूर्ववत"
            }

        case .undoDesc:
            switch lang {
            case .english:    return "Undo the last action"
            case .japanese:   return "直前の操作を元に戻す"
            case .thai:       return "ย้อนกลับ 1 ขั้น"
            case .chinese:    return "撤销上一步操作"
            case .vietnamese: return "Hoàn tác bước cuối"
            case .french:     return "Annuler la dernière action"
            case .spanish:    return "Deshacer última acción"
            case .portuguese: return "Desfazer última ação"
            case .german:     return "Letzte Aktion rückgängig"
            case .hindi:      return "पिछला कार्य पूर्ववत"
            }

        case .undoConfirmMessage:
            switch lang {
            case .english:    return "Revert to the previous state?"
            case .japanese:   return "直前の状態に戻しますか？"
            case .thai:       return "ย้อนกลับ?"
            case .chinese:    return "恢复到上一个状态？"
            case .vietnamese: return "Hoàn tác?"
            case .french:     return "Revenir à l'état précédent?"
            case .spanish:    return "¿Volver al estado anterior?"
            case .portuguese: return "Voltar ao estado anterior?"
            case .german:     return "Vorherigen Stand?"
            case .hindi:      return "पिछली स्थिति में?"
            }

        case .newItemDesc:
            switch lang {
            case .english:    return "Add a new clipboard item"
            case .japanese:   return "新しいアイテムを追加"
            case .thai:       return "เพิ่มใหม่"
            case .chinese:    return "添加新项目"
            case .vietnamese: return "Thêm mới"
            case .french:     return "Ajouter un élément"
            case .spanish:    return "Añadir nuevo ítem"
            case .portuguese: return "Adicionar novo item"
            case .german:     return "Neuen Eintrag hinzufügen"
            case .hindi:      return "नई आइटम जोड़ें"
            }

        case .longPress:
            switch lang {
            case .english:    return "Long Press on Row"
            case .japanese:   return "行を長押し"
            case .thai:       return "กดค้าง"
            case .chinese:    return "长按行"
            case .vietnamese: return "Giữ lâu"
            case .french:     return "App. long"
            case .spanish:    return "Mantener"
            case .portuguese: return "Pressão longa"
            case .german:     return "Lang drücken"
            case .hindi:      return "देर दबाएं"
            }

        case .moveToTop:
            switch lang {
            case .english:    return "Move to Top"
            case .japanese:   return "先頭に移動"
            case .thai:       return "ขึ้นบน"
            case .chinese:    return "移到顶部"
            case .vietnamese: return "Lên đầu"
            case .french:     return "En haut"
            case .spanish:    return "Arriba"
            case .portuguese: return "Ao topo"
            case .german:     return "Nach oben"
            case .hindi:      return "ऊपर"
            }

        case .moveToTopDesc:
            switch lang {
            case .english:    return "Move item to top of list"
            case .japanese:   return "一覧の先頭へ移動"
            case .thai:       return "ย้ายขึ้นบนสุด"
            case .chinese:    return "将项目移到列表顶部"
            case .vietnamese: return "Chuyển lên đầu"
            case .french:     return "Déplacer en haut"
            case .spanish:    return "Mover al inicio"
            case .portuguese: return "Mover ao topo"
            case .german:     return "An den Anfang"
            case .hindi:      return "सूची में ऊपर"
            }

        case .editCategoryDesc:
            switch lang {
            case .english:    return "Change the item's category"
            case .japanese:   return "カテゴリを変更"
            case .thai:       return "เปลี่ยนหมวด"
            case .chinese:    return "更改项目分类"
            case .vietnamese: return "Đổi danh mục"
            case .french:     return "Changer la catégorie"
            case .spanish:    return "Cambiar categoría"
            case .portuguese: return "Alterar categoria"
            case .german:     return "Kategorie ändern"
            case .hindi:      return "वर्ग बदलें"
            }

        case .deleteDesc:
            switch lang {
            case .english:    return "Delete item from list"
            case .japanese:   return "一覧から削除"
            case .thai:       return "ลบรายการ"
            case .chinese:    return "从列表中删除"
            case .vietnamese: return "Xóa mục"
            case .french:     return "Supprimer l'élément"
            case .spanish:    return "Eliminar ítem"
            case .portuguese: return "Excluir item"
            case .german:     return "Eintrag löschen"
            case .hindi:      return "आइटम हटाएं"
            }
        }
    }
}
