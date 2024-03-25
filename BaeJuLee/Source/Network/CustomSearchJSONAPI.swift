//
//  GoogleCustomSearchJSONAPI.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/24/24.
//

import Foundation
import Alamofire

enum CustomSearchAPI {
    case search(query: String)
    
    var baseURL: String {
        return "https://www.googleapis.com/customsearch/v1"
    }
    
    var apiKey: String {
        return Bundle.main.CustomSearchJSONAPIKey
    }
    
    var cx: String {
        return Bundle.main.CustomSearchJSONCx
    }
    
    var endpoint: URL {
        switch self {
        case .search:
            return URL(string: baseURL)!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters {
        switch self {
        case .search(let query):
            return [
                "key": apiKey,
                "cx": cx,
                "q": query
            ]
        }
    }
}

