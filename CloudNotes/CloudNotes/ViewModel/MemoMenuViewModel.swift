//
//  MemoMenuViewModel.swift
//  CloudNotes
//
//  Created by JeongTaek Han on 2022/02/09.
//

import Foundation
import UIKit.NSDataAsset

final class MemoMenuViewModel {
    
    private var model: MemoModel {
        didSet { uiHandler?() }
    }
    
    private var uiHandler: (() -> Void)?
    
    init(handler: (() -> Void)? = nil) {
        let sampleAsset = NSDataAsset(name: "sample")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let jsonData = sampleAsset?.data,
              var decodedJSON = try? decoder.decode([Memo].self, from: jsonData) else {
                  self.model = MemoModel(memo: [])
                  return
        }
        
        decodedJSON.indices.forEach { decodedJSON[$0].id = UUID() }
        model = MemoModel(memo: decodedJSON)
        
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
