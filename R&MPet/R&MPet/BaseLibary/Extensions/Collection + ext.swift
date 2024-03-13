//
//  Collection + ext.swift
//  R&MPet
//
//  Created by Максим Сулим on 20.02.2024.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return saveObject(at: index)
    }
    
    ///Safely removing the element
    func saveObject(at index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
