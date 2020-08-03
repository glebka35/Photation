//
//  CloudMersiveClient.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 21.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import GUNetworkLayer

class CloudMersiveClient {

//    MARK: - Properties

    var baseURL = URL(string: "https://api.cloudmersive.com")!
    var boundary = "Boundary-\(UUID().uuidString)"
    var headers: HTTPHeaders

    private let networkManager: ApiClient
    private var settings: ClientSettings

//    MARK: - Life cycle

    init() {
        headers = ["Apikey": "d90f3529-f5d3-4048-9d7c-46a4a35829c4", "Content-Type":"multipart/form-data; boundary=\(boundary)"]

        settings = ClientSettings(baseHeaders: headers)
        let provider = HTTPProvider(settings: settings, baseURL: baseURL)
        networkManager = ApiClient(provider: provider)
    }

//    MARK: - Recognition

    func getRecognition(of image: Data?, name: String, completion: @escaping (_ objects: [Object]?, _ success: Bool?)->()) {
        if let data = image {
            let request = Request(path: "/image/recognize/detect-objects", httpMethod: .post, task: .requestParameters(bodyParameters: nil, bodyContentType: .multipartFormData(boundary: boundary, data: data, mimeType: "image/jpg", filename: name), urlParameters: nil))

            networkManager.execute(request: request) {(response, error) in
                if let response = response {
                    print(response.statusCode)
                    if let data = response.data {
                        do {
                            let apiResponse = try JSONDecoder().decode(CloudMersiveApiResponse.self, from: data)
                            completion(apiResponse.objects, apiResponse.successful)
                        } catch {
                            print("Can not decode response")
                            completion(nil, nil)
                        }
                    }
                } else {
                    print("error: response is nil")
                    completion(nil, nil)
                }
            }
        }
    }

//    MARK: - Response decoding

    private func decodeResponse(response: Response)->[Object]? {
        guard let data = response.data else { return nil }
        do {
            let apiResponse = try JSONDecoder().decode(CloudMersiveApiResponse.self, from: data)
            return apiResponse.objects
        } catch {
            print("Can not decode response")
            return nil
        }
    }
}
