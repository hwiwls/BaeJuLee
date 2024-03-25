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
    func searchJSONImage(api: CustomSearchAPI, completionHandler: @escaping (Result<Search, AFError>) -> Void) {
        AF.request(
            api.endpoint,
            method: api.method,
            parameters: api.parameters
        ).responseDecodable(of: Search.self) { response in
            completionHandler(response.result)
        }
    }
}

