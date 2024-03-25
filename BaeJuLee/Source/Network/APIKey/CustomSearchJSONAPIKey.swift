//
//  CustomSearchJSONAPIKey.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/24/24.
//

import Foundation

extension Bundle {
    var CustomSearchJSONAPIKey: String {
        guard let file = self.path(forResource: "CustomSearchJSON-info", ofType: "plist") else { return "" }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        
        guard let key = resource["CustomSearchJSON_API_KEY"] as? String else {
            fatalError("CustomSearchJSON_API_KEY error")
        }
        return key
    }
    
    var CustomSearchJSONCx: String {
        guard let file = self.path(forResource: "CustomSearchJSON-info", ofType: "plist") else { return "" }
        
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        
        guard let key = resource["CustomSearchJSON_CX"] as? String else {
            fatalError("CustomSearchJSON_CX error")
        }
        return key
    }
}
