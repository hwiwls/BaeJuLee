//
//  GoogleCustomSearchJSONAPI.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/24/24.
//

//import Foundation
//import Alamofire
//
//enum CustomSearchAPI {
//    case search(query: String)
//    
//    var baseURL: String {
//        return "https://www.googleapis.com/customsearch/v1"
//    }
//    
//    var apiKey: String {
//        return Bundle.main.CustomSearchJSONAPIKey2
//    }
//    
//    var cx: String {
//        return Bundle.main.CustomSearchJSONCx2
//    }
//    
//    var endpoint: URL {
//        switch self {
//        case .search:
//            return URL(string: baseURL)!
//        }
//    }
//    
//    var method: HTTPMethod {
//        return .get
//    }
//    
//    var parameters: Parameters {
//        switch self {
//        case .search(let query):
//            return [
//                "key": apiKey,
//                "cx": cx,
//                "q": query
//            ]
//        }
//    }
//}
//

import Foundation
import Alamofire

enum CustomSearchAPI {
    case search(query: String, apiKey: String, cx: String)
    
    var baseURL: String {
        return "https://www.googleapis.com/customsearch/v1"
    }
    
    var endpoint: URL {
        switch self {
        case .search:
            return URL(string: baseURL)!
        }
    }
    
    var parameters: (Parameters, HTTPMethod) {
        switch self {
        case .search(let query, let apiKey, let cx):
            return ([
                "key": apiKey,
                "cx": cx,
                "q": query
            ], .get)
        }
    }
}
