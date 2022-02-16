//
//  TypeNameConvertible.swift
//  CloudNotes
//
//  Created by JeongTaek Han on 2022/02/17.
//

import UIKit

protocol TypeNameConvertible: AnyObject {
    
    static var reuseIdentifier: String { get }
    
}

extension TypeNameConvertible where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}
