//
//  MemoMenuViewModel.swift
//  CloudNotes
//
//  Created by JeongTaek Han on 2022/02/09.
//

import Foundation
import UIKit.NSDataAsset

final class MemoMenuViewModel {
    
    private var model = MemoModel() {
        didSet { uiHandler?() }
    }
    
    private var uiHandler: (() -> Void)?
    
    init(handler: (() -> Void)? = nil) {
        uiHandler = handler
    }
    
    var title: String { return "메모" }
    
    var sectionCount: Int { return 1 }
    
    var memos: [Memo] { return model.memos }
    
    func cellTitle(at index: Int) -> String {
        return memos[index].title
    }
    
    func removeMemo(at index: Int) {
        model.deleteMemo(at: index)
    }
    
}
