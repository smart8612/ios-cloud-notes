//
//  MemoMenuTableViewDiffableDataSource.swift
//  Pods
//
//  Created by JeongTaek Han on 2022/02/10.
//

import UIKit

class MemoMenuTableViewDiffableDataSource: UITableViewDiffableDataSource<Section, Memo> {
    
    var viewModel: MemoMenuViewModel?
    
    convenience init(tableView: UITableView, viewModel: MemoMenuViewModel,
                     cellProvider: @escaping UITableViewDiffableDataSource<Section, Memo>.CellProvider) {
        self.init(tableView: tableView, cellProvider: cellProvider)
        self.viewModel = viewModel
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel?.removeMemo(at: indexPath)
        }
    }

}
