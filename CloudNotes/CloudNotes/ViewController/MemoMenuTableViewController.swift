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
            tableView: self.tableView, viewModel: self.viewModel) { (view, indexPath, _) in
                let cell = view.dequeueReusableCell(
                    withIdentifier: MemoListTableViewCell.reuseIdentifier, for: indexPath)
                
                if let cell = cell as? MemoListTableViewCell {
                    let viewModel = self.viewModel
                    let index = indexPath.row
                    cell.setLabelText(
                        title: viewModel.cellTitle(at: index),
                        body: viewModel.cellBody(at: index),
                        lastModified: viewModel.cellLastModified(at: index)
                    )
                }
                
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
        
        tableView.register(MemoListTableViewCell.self)
        
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

extension UITableView {
    
    func register<Cell: UITableViewCell>(_: Cell.Type) where Cell: TypeNameConvertible {
        register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
    }
    
}

