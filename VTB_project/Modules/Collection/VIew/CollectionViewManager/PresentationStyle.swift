//
//  PresentationStyle.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 08.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

public enum PresentationStyle: CaseIterable {
    case table
    case images
    
    var buttonImage: String {
        switch self {
        case .table: return "table"
        case .images: return "fourSquares"
        }
    }
}
