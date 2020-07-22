//
//  HTTPProvider.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 22.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import GUNetworkLayer


struct HTTPProvider: ClientSettingsProviderProtocol {
    var settings: ClientSettings
    var baseURL: URL
}
