//
//  CloudNotes - MemoDetailViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MemoDetailViewController: UIViewController {
    var memo: Memo?
    
    let contentTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Hello World"
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(contentTextView)
        NSLayoutConstraint.activate([
            contentTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentTextView.topAnchor.constraint(equalTo: self.view.topAnchor),
            contentTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension MemoDetailViewController: MemoSelectedDelegate {
    func memoSelected(_ newMemo: Memo) {
        self.memo = newMemo
        contentTextView.text = memo?.body
    }
}
