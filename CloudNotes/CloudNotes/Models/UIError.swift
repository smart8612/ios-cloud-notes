//
//  UIError.swift
//  CloudNotes
//
//  Created by Ryan-Son on 2021/06/03.
//

import Foundation

enum UIError: Error {
    case collectionViewNotSet
    case downcastingFailed(subject: String, location: String)
    case delegateNotSet(delegateName: String)
}

extension UIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .collectionViewNotSet:
            return "Collection view is not set."
        case let .downcastingFailed(subject, location):
            return "\(subject) failed to downcast at \(location). "
        case let .delegateNotSet(delegateName):
            return "\(delegateName) is not set."
        }
    }
}
