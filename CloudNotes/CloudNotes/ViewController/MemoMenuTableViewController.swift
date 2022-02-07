//
//  MemoMenuTableViewController.swift
//  CloudNotes
//
//  Created by JeongTaek Han on 2022/02/08.
//

import UIKit

class MemoMenuTableViewController: UITableViewController {
    
    var memo: [Memo] = []
    
    let addBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        return barButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = "메모"
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = addBarButton
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let sampleAsset = NSDataAsset(name: "sample")
        guard let jsonData = sampleAsset?.data else { return }
        guard let decodedJSON = try? JSONDecoder().decode([Memo].self, from: jsonData) else { return }
        memo = decodedJSON
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memo.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "\(memo[indexPath.row].title)"
        cell.contentConfiguration = content
        return cell
    }

}
