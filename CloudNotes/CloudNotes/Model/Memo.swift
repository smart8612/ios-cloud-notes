//
//  Memo.swift
//  CloudNotes
//
//  Created by JeongTaek Han on 2022/02/08.
//

import Foundation

struct Memo: Codable, Hashable {
    
    var id: UUID?
    var title: String
    var body: String
    var lastModified: Date
    
}
