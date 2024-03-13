//
//  LocalizableString.swift
//  R&MPet
//
//  Created by Максим Сулим on 21.02.2024.
//

import Foundation

protocol LocalizableString: RawRepresentable {
    var localized: String { get }
}

extension LocalizableString {
    var localized: String {
        NSLocalizedString(self.rawValue as? String ?? "", comment: "")
    }
}
