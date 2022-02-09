//
//  MemoMenuTableViewController.swift
//  CloudNotes
//
//  Created by JeongTaek Han on 2022/02/08.
//

import UIKit

class MemoMenuTableViewController: UITableViewController {
    
    private(set) lazy var viewModel = MemoMenuViewModel(handler: self.updateUI)
    
    var delegate: MemoSelectedDelegate?
    
    let addBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        return barButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = viewModel.title
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = addBarButton
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func updateUI() {
        tableView.reloadData()
    }

}

// MARK: - Table view data source
extension MemoMenuTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.memos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = viewModel.cellTitle(at: indexPath.row)
        cell.contentConfiguration = content
        return cell
    }
    
}

// MARK: - Tablew view delegate
extension MemoMenuTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentMemo = viewModel.memos[indexPath.row]
        delegate?.memoSelected(currentMemo)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView,
                            editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeMemo(at: indexPath.row)
        }
    }
    
}
