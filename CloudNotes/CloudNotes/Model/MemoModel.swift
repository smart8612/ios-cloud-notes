//
//  MemoModel.swift
//  CloudNotes
//
//  Created by JeongTaek Han on 2022/02/09.
//

import Foundation

struct MemoModel {
    
    private(set) var memos: [Memo] = []
    
    init(memo: [Memo]) {
        self.memos = memo
    }
    
    mutating func deleteMemo(at index: Int) {
        memos.remove(at: index)
    }
    
}
