//
//  Memo.swift
//  CloudNotes
//
//  Created by KimJaeYoun on 2021/08/31.
//

import Foundation

struct Memo: Decodable {
    let title: String
    let body: String
    let lastModified: Int
    
    var locationDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        let date = Date(timeIntervalSince1970: TimeInterval(lastModified))
        
        return dateFormatter.string(from: date)
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case body
        case lastModified = "last_modified"
    }
}

struct SampleMemo {
    static func setupSampleMemo() -> [Memo] {
        
        guard let path = Bundle.main.path(forResource: "sample", ofType: "json") else {
            return [Memo]()
        }
        
        guard let sampleData = try? String(contentsOfFile: path).data(using: .utf8) else {
            return [Memo]()
        }
        
        guard let decodedData = JsonManager.decode(type: [Memo].self, data: sampleData) else {
            return [Memo]()
        }
        
        return decodedData
    }
}
