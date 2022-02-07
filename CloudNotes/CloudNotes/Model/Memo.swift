//
//  Memo.swift
//  CloudNotes
//
//  Created by JeongTaek Han on 2022/02/08.
//

import Foundation

struct Memo: Codable {
    let title: String
    let body: String
    let lastModified: Date
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case body = "body"
        case lastModified = "last_modified"
    }
}
