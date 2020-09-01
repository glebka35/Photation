//
//  Array+.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 28.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

extension Collection {
    subscript(safelyAccess index: Index) -> Element? {
        get { return self.indices.contains(index) ? self[index] : nil }
    }
}
