//
//  MemoMenuViewModel.swift
//  CloudNotes
//
//  Created by JeongTaek Han on 2022/02/09.
//

import Foundation
import UIKit.NSDataAsset

class MemoMenuViewModel {
    
    let model: MemoModel
    
    init() {
        let sampleAsset = NSDataAsset(name: "sample")
        guard let jsonData = sampleAsset?.data,
              let decodedJSON = try? JSONDecoder().decode([Memo].self, from: jsonData) else {
                  self.model = MemoModel(memo: [])
                  return
        }
        self.model = MemoModel(memo: decodedJSON)
    }
    
    var title: String { return "메모" }
    
    var memos: [Memo] { return model.memos }
    
}
