//
//  CaseNameable.swift
//  MinimalCountdown
//
//  Created by Sergey Kemenov
//

import Foundation

protocol CaseNameable {
    var name: String { get }
}

extension CaseNameable {
    var name: String {
        String(describing: self).capitalized
    }
}
