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
    
    let fetchResultsController: NSFetchedResultsController<Note> = {
        let request = Note.fetchRequest()
        let dateTimeSort = NSSortDescriptor(key: "lastModified", ascending: true)
        let context = CloudNotesDataController.shared.context
        request.sortDescriptors = [dateTimeSort]
        return NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil, cacheName: nil
        )
    }()
    
    private var notes: [Note] {
        guard let notes = fetchResultsController.fetchedObjects else {
            return []
        }
        return notes
    }
    
    var memos: [Memo] {
        notes.map {
            Memo(
                id: $0.id,
                title: $0.title ?? "",
                body: $0.body ?? "",
                lastModified: $0.lastModified ?? Date()
            )
        }
    }
    
    func memo(at indexPath: IndexPath) -> Memo {
        let note = fetchResultsController.object(at: indexPath)
        return Memo(
            id: note.id,
            title: note.title ?? "",
            body: note.body ?? "",
            lastModified: note.lastModified ?? Date()
        )
    }
    
    func create(memo: Memo) {
        dataController.create(entity: "Note") { managedObject in
            [
                "identifier": UUID(),
                "title": memo.title,
                "body": memo.body,
                "lastModified": Date()
            ].forEach { key, value in
                managedObject.setValue(value, forKey: key)
            }
        }
    }
    
    func update(at id: UUID, to memo: Memo) {
        let request = Note.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id.uuidString)
        dataController.update(request: request) { managedObject in
            managedObject.setValue(id, forKey: "id")
            managedObject.setValue(memo.title, forKey: "title")
            managedObject.setValue(memo.body, forKey: "body")
            managedObject.setValue(Date(), forKey: "lastModified")
        }
    }
    
    func delete(at id: UUID) {
        let request = Note.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id.uuidString)
        guard let result = dataController.fetch(request: request).first else {
            return
        }
        dataController.delete(object: result)
    }
    
}
