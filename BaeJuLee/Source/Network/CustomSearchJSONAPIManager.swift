//
//  CustomSearchJSONAPIManager.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/24/24.
//

import Alamofire
import Foundation

enum CustomSearchAPIError: Error {
    case allAPIKeysExhausted
}

class CustomSearchJSONAPIManager {
    static let shared = CustomSearchJSONAPIManager()
    
    private var apiKeyAndCxTuples: [(apiKey: String, cx: String)] = [
        (Bundle.main.CustomSearchJSONAPIKey2, Bundle.main.CustomSearchJSONCx2),
        (Bundle.main.CustomSearchJSONAPIKey, Bundle.main.CustomSearchJSONCx),
        (Bundle.main.CustomSearchJSONAPIKey3, Bundle.main.CustomSearchJSONCx3)
    ]
    
    private func searchJSONImage(query: String, retryCount: Int = 0, completionHandler: @escaping (Result<Search, Error>) -> Void) {
        guard retryCount < apiKeyAndCxTuples.count else {
            completionHandler(.failure(CustomSearchAPIError.allAPIKeysExhausted))
            return
        }
        
        let (apiKey, cx) = apiKeyAndCxTuples[retryCount]
        let parameters: Parameters = [
            "key": apiKey,
            "cx": cx,
            "q": query
        ]
        
        let baseURL = "https://www.googleapis.com/customsearch/v1"
        
        
        AF.request(
            baseURL,
            method: .get,
            parameters: parameters
        ).validate().responseDecodable(of: Search.self) { [weak self] response in
            switch response.result {
            case .success(let searchResult):
                completionHandler(.success(searchResult))
            case .failure(let error):
                if let afError = error.asAFError, afError.responseCode == 429, retryCount < self?.apiKeyAndCxTuples.count ?? 0 {
                    self?.searchJSONImage(query: query, retryCount: retryCount + 1, completionHandler: completionHandler)
                } else {
                    completionHandler(.failure(error))
                }
            }
        }
    }
    
    func searchForImage(query: String, completionHandler: @escaping (Result<Search, Error>) -> Void) {
        searchJSONImage(query: query, completionHandler: completionHandler)
    }
}

