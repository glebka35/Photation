//
//  UniqueClientResponse.swift
//  Photation
//
//  Created by Уваркин Глеб Александрович on 07.01.2022.
//  Copyright © 2022 Gleb Uvarkin. All rights reserved.
//

import Foundation

struct NetworkClientResponse {
    let successful: Bool
    let objects: [Object]
    let objectCount: Int
}

extension NetworkClientResponse: Decodable {

    private enum NetworkClientResponseCodingKeys: String, CodingKey {
        case success = "Successful"
        case objects = "Objects"
        case objectCount = "ObjectCount"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: NetworkClientResponseCodingKeys.self)

        successful = try container.decode(Bool.self, forKey: .success)
        objectCount = try container.decode(Int.self, forKey: .objectCount)
        objects = try container.decode([Object].self, forKey: .objects)
    }
}

struct Object {
    let nativeLanguage: String
    let foreignLanguage: String
    let height: Int
    let width: Int
    let score: Double
    let x: Int
    let y: Int
}

extension Object: Decodable {
    enum ObjectCodingKeys: String, CodingKey {
        case nativeLanguage = "native_lang"
        case foreignLanguage = "foreign_lang"
        case height = "Height"
        case width = "Width"
        case score = "Score"
        case x = "X"
        case y = "Y"
    }

    init(from decoder: Decoder) throws {
        let objectContainer = try decoder.container(keyedBy: ObjectCodingKeys.self)

        nativeLanguage = try objectContainer.decode(String.self, forKey: .nativeLanguage)
        foreignLanguage = try objectContainer.decode(String.self, forKey: .foreignLanguage)
        height = try objectContainer.decode(Int.self, forKey: .height)
        width = try objectContainer.decode(Int.self, forKey: .width)
        score = try objectContainer.decode(Double.self, forKey: .score)
        x = try objectContainer.decode(Int.self, forKey: .x)
        y = try objectContainer.decode(Int.self, forKey: .y)
    }
}
