//
//  LanguageProvider.swift
//  Photation
//
//  Created by Gleb Uvarkin on 24.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

struct Lang {
    let code: String
    let humanRepresantationNative: String
    let humanRepresentationEnglish: String
}

enum LanguageProviderError: Error {
    case fileNotFound
}

class LanguageProvider {

    private(set) var humanRepresentationNative: [String:String] = [:]
    private(set) var humanRepresentationEnglish: [String:String] = [:]


    private let plistName = "Languages"


     init() throws {
        let data = try getDataFromPlist()
        let parsedModels = try parse(data: data)

        humanRepresentationNative = parsedModels["humanRepresentationNative"] ?? [:]
        humanRepresentationEnglish = parsedModels["humanRepresentationEnglish"] ?? [:]
    }

    private func getDataFromPlist() throws -> Data  {
        guard let urlString = Bundle.main.path(forResource: plistName, ofType: "plist"), let url = URL(string: urlString) else { throw LanguageProviderError.fileNotFound }

        return try Data(contentsOf: url)
    }

    private func parse(data: Data) throws -> [String:[String:String]] {
        try PropertyListDecoder().decode([String:[String:String]].self, from: data)
    }


}
