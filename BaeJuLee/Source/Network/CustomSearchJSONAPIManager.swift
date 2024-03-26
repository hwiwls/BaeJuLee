//
//  CustomSearchJSONAPIManager.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/24/24.
//

import Foundation
import Alamofire

class CustomSearchJSONAPIManager {
    static let shared = CustomSearchJSONAPIManager()

    private var apiKeys = [
        Bundle.main.CustomSearchJSONAPIKey,
        Bundle.main.CustomSearchJSONAPIKey2,
        Bundle.main.CustomSearchJSONAPIKey3,
        Bundle.main.CustomSearchJSONAPIKey4
    ]
    private var cxs = [
        Bundle.main.CustomSearchJSONCx,
        Bundle.main.CustomSearchJSONCx2,
        Bundle.main.CustomSearchJSONCx3,
        Bundle.main.CustomSearchJSONCx4
    ]

    func searchJSONImage(query: String, completionHandler: @escaping (Result<Search, AFError>) -> Void) {
        attemptSearch(query: query, apiKeyIndex: 0, completionHandler: completionHandler)
    }

    private func attemptSearch(query: String, apiKeyIndex: Int, completionHandler: @escaping (Result<Search, AFError>) -> Void) {
        if apiKeyIndex >= apiKeys.count {
            completionHandler(.failure(AFError.responseValidationFailed(reason: .dataFileNil)))
            return
        }
        
        let apiKey = apiKeys[apiKeyIndex]
        let cx = cxs[apiKeyIndex]
        let endpoint = "https://www.googleapis.com/customsearch/v1"
        let parameters: Parameters = [
            "key": apiKey,
            "cx": cx,
            "q": query
        ]
        
        let method: HTTPMethod = .get
        
        // Constructing the URL for debugging purposes
        var urlComponents = URLComponents(string: endpoint)!
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        if let url = urlComponents.url {
            print("Requesting URL: \(url.absoluteString)")
        }

        AF.request(
            endpoint,
            method: method,
            parameters: parameters
        ).validate().responseDecodable(of: Search.self) { response in
            switch response.result {
            case .success:
                completionHandler(response.result)
            case .failure(let error):
                if let afError = error.asAFError, afError.responseCode == 429, apiKeyIndex + 1 < self.apiKeys.count {
                    self.attemptSearch(query: query, apiKeyIndex: apiKeyIndex + 1, completionHandler: completionHandler)
                } else {
                    completionHandler(.failure(error))
                }
            }
        }
    }
}
