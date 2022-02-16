//
//  MemoMenuViewModel.swift
//  CloudNotes
//
//  Created by JeongTaek Han on 2022/02/09.
//

import Foundation
import CoreData

final class MemoMenuViewModel {
    
    private var model = MemoModel()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("yyyy MM dd")
        formatter.locale = NSLocale.current
        return formatter
    }()
    
    init(delegate: NSFetchedResultsControllerDelegate) {
        model.fetchResultsController.delegate = delegate
        try? model.fetchResultsController.performFetch()
    }
    
    var title: String { return "메모" }
    
    var sectionCount: Int { return 1 }
    
    var memos: [Memo] { return model.memos }
    
    func cellTitle(at indexPath: IndexPath) -> String {
        return model.memo(at: indexPath).title
    }
    
    func cellBody(at indexPath: IndexPath) -> String {
        return model.memo(at: indexPath).body
    }
    
    func cellLastModified(at indexPath: IndexPath) -> String {
        let date = model.memo(at: indexPath).lastModified
        return dateFormatter.string(from: date)
    }
    
    func removeMemo(at indexPath: IndexPath) {
        guard let id = model.memo(at: indexPath).id else { return }
        model.delete(at: id)
    }
    
}
