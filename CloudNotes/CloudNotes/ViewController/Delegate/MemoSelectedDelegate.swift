//
//  MemoSelectedDelegate.swift
//  CloudNotes
//
//  Created by JeongTaek Han on 2022/02/08.
//

import Foundation

protocol MemoSelectedDelegate: AnyObject {
    
    func memoSelected(_ newMemo: Memo)
    
}
