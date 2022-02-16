//
//  MemoMenuViewModel.swift
//  CloudNotes
//
//  Created by JeongTaek Han on 2022/02/09.
//

import Foundation

final class MemoMenuViewModel {
    
    private var model = MemoModel() {
        didSet { uiHandler?() }
    }
    
    private var uiHandler: (() -> Void)?
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("yyyy MM dd")
        formatter.locale = NSLocale.current
        return formatter
    }()
    
    init(handler: (() -> Void)? = nil) {
        uiHandler = handler
    }
    
    var title: String { return "메모" }
    
    var sectionCount: Int { return 1 }
    
    var memos: [Memo] { return model.memos }
    
    func cellTitle(at index: Int) -> String {
        return memos[index].title
    }
    
    func cellBody(at index: Int) -> String {
        return memos[index].body
    }
    
    func cellLastModified(at index: Int) -> String {
        let date = memos[index].lastModified
        return dateFormatter.string(from: date)
    }
    
    func removeMemo(at index: Int) {
        guard let id = memos[index].id else { return }
        model.delete(at: id)
    }
    
}
