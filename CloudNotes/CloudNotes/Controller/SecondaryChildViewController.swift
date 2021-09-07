//
//  SecondaryChildViewController.swift
//  CloudNotes
//
//  Created by 홍정아 on 2021/09/06.
//

import UIKit

class SecondaryChildViewController: UIViewController {
    private var bodyTextView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func initContent(of note: Note) {
        showContent(of: note)
        styleContent()
        layoutContent()
    }

    private func showContent(of note: Note) {
        bodyTextView.text = note.body
    }
    
    private func styleContent() {
        bodyTextView.font = UIFont.preferredFont(forTextStyle: .body)
        view.backgroundColor = .white
    }
    
    private func layoutContent() {
        view.addSubview(bodyTextView)
        bodyTextView.translatesAutoresizingMaskIntoConstraints = false
        bodyTextView.leadingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bodyTextView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bodyTextView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        bodyTextView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
