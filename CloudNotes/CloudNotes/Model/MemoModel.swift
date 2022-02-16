//
//  MemoModel.swift
//  CloudNotes
//
//  Created by JeongTaek Han on 2022/02/09.
//

import Foundation
import CoreData

struct MemoModel {
    
    var dataController: CloudNotesDataController {
        CloudNotesDataController.shared
    }
    
    private(set) var memos: [Memo] = []
    
    init() {
        fetch()
    }
    
    mutating func fetch() {
        let request = Note.fetchRequest()
        let result = dataController.fetch(request: request)
        self.memos = result.map({ note in
            Memo(id: note.id, title: note.title ?? "", body: note.body ?? "", lastModified: note.lastModified ?? Date())
        })
    }
    
    func create(memo: Memo) {
        dataController.create(entity: "Note") { managedObject in
            managedObject.setValue(memo.id, forKey: "id")
            managedObject.setValue(memo.title, forKey: "title")
            managedObject.setValue(memo.body, forKey: "body")
            managedObject.setValue(memo.lastModified, forKey: "lastModified")
        }
    }
    
    mutating func deleteMemo(at index: Int) {
        memos.remove(at: index)
    }
    
}
