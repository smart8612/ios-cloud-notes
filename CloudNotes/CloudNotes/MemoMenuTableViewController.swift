//
//  MemoMenuTableViewController.swift
//  CloudNotes
//
//  Created by JeongTaek Han on 2022/02/08.
//

import UIKit

class MemoMenuTableViewController: UITableViewController {
    let addBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        return barButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "메모"
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = addBarButton
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "section: \(indexPath.section), row: \(indexPath.row)"
        cell.contentConfiguration = content
        return cell
    }

}
