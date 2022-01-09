//
//  UniqueClient.swift
//  Photation
//
//  Created by Уваркин Глеб Александрович on 07.01.2022.
//  Copyright © 2022 Gleb Uvarkin. All rights reserved.
//

import Foundation
import GUNetworkLayer

final class NetworkClient {
    private let baseURL = URL(string: "http://0.0.0.0:5000")!

    private let networkManager: ApiClient
    private let headers: HTTPHeaders
    private let settings: ClientSettings

    private let boundary = "Boundary-\(UUID().uuidString)"

    init() {
        headers = ["Content-Type":"multipart/form-data; boundary=\(boundary)"]
        settings = ClientSettings(baseHeaders: headers)
        let provider = HTTPProvider(settings: settings, baseURL: baseURL)
        networkManager = ApiClient(provider: provider)
    }

    func getRecognition(
        of image: Data?,
        nativeLang: String,
        foreignLang: String,
        completion: @escaping (_ objects: [Object]?, _ success: Bool) -> Void
    ) {
        guard let data = image else {
            completion(nil, false)
            return
        }

        let bodyParameters = [
            MultiPartDataKeys.boundary.rawValue: boundary,
            MultiPartDataKeys.key.rawValue: "imageFile",
            MultiPartDataKeys.type.rawValue: "image/jpg",
            MultiPartDataKeys.fileName.rawValue: "image.jpg",
            MultiPartDataKeys.value.rawValue: data
        ] as [String : Any]

        let request = Request(
            path: "/image/recognize/detect-objects",
            httpMethod: .post,
            task: .requestParameters(
                bodyParameters: bodyParameters,
                bodyContentType: .multipartFormData,
                urlParameters: [
                    "foreign_lang": SettingsStore.shared.getForeignLanguage().rawValue,
                    "native_lang": SettingsStore.shared.getNativeLanguage().rawValue
                ]
            )
        )

        networkManager.execute(request: request) {(response, error) in
            if let response = response {
                print(response.statusCode)
                if let data = response.data {
                    do {
                        let apiResponse = try JSONDecoder().decode(NetworkClientResponse.self, from: data)
                        completion(apiResponse.objects, apiResponse.successful)
                    } catch {
                        print("Can not decode response")
                        completion(nil, false)
                    }
                }
            } else {
                print("error: response is nil")
                completion(nil, false)
            }
        }
    }
}
