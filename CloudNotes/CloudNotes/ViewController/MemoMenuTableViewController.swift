//
//  MemoMenuTableViewController.swift
//  CloudNotes
//
//  Created by JeongTaek Han on 2022/02/08.
//

import UIKit

final class MemoMenuTableViewController: UITableViewController {
    
    private(set) lazy var viewModel = MemoMenuViewModel(handler: self.updateUI)
    
    var delegate: MemoSelectedDelegate?
    
    private lazy var dataSource = {
        return MemoMenuTableViewDiffableDataSource(
            tableView: self.tableView, viewModel: self.viewModel) { (view, indexPath, item) in
            let cell = view.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            cell.contentConfiguration = content
            return cell
        }
    }()
    
    private let addBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        return barButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = viewModel.title
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = addBarButton
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        updateUI()
    }
    
    private func updateUI() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Memo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.memos, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

}

// MARK: - Table view delegate
extension MemoMenuTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentMemo = viewModel.memos[indexPath.row]
        delegate?.memoSelected(currentMemo)
    }
    
    override func tableView(_ tableView: UITableView,
                            editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
}
