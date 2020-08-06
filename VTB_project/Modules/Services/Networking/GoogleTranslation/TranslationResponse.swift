//
//  TranslationResponse.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 22.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation


struct TranslationApiResponse {
    let data: TranslationData
}

extension TranslationApiResponse: Decodable {

    private enum CloudMersiveApiResponseCodingKeys: String, CodingKey {
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CloudMersiveApiResponseCodingKeys.self)

        data = try container.decode(TranslationData.self, forKey: .data)
    }
}

struct TranslationData {
    let translations: [TranslatedText]
}

extension TranslationData: Decodable {

    enum ObjectCodingKeys: String, CodingKey {
        case translations = "translations"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ObjectCodingKeys.self)

        translations = try container.decode([TranslatedText].self, forKey: .translations)
    }
}

struct TranslatedText {
    let translatedText: String
}

extension TranslatedText: Decodable {

    enum ObjectCodingKeys: String, CodingKey {
        case translatedText = "translatedText"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ObjectCodingKeys.self)

        translatedText = try container.decode(String.self, forKey: .translatedText)
    }
}
