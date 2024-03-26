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
    
    var CustomSearchJSONAPIKey2: String {
        guard let file = self.path(forResource: "CustomSearchJSON-info", ofType: "plist") else { return "" }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        
        guard let key = resource["CustomSearchJSON_API_KEY2"] as? String else {
            fatalError("CustomSearchJSON_API_KEY2 error")
        }
        return key
    }
    
    var CustomSearchJSONAPIKey3: String {
        guard let file = self.path(forResource: "CustomSearchJSON-info", ofType: "plist") else { return "" }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        
        guard let key = resource["CustomSearchJSON_API_KEY3"] as? String else {
            fatalError("CustomSearchJSON_API_KEY3 error")
        }
        return key
    }
    
    var CustomSearchJSONAPIKey4: String {
        guard let file = self.path(forResource: "CustomSearchJSON-info", ofType: "plist") else { return "" }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        
        guard let key = resource["CustomSearchJSON_API_KEY4"] as? String else {
            fatalError("CustomSearchJSON_API_KEY3 error")
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
    
    var CustomSearchJSONCx2: String {
        guard let file = self.path(forResource: "CustomSearchJSON-info", ofType: "plist") else { return "" }
        
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        
        guard let key = resource["CustomSearchJSON_CX2"] as? String else {
            fatalError("CustomSearchJSON_CX2 error")
        }
        return key
    }
    
    var CustomSearchJSONCx3: String {
        guard let file = self.path(forResource: "CustomSearchJSON-info", ofType: "plist") else { return "" }
        
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        
        guard let key = resource["CustomSearchJSON_CX3"] as? String else {
            fatalError("CustomSearchJSON_CX3 error")
        }
        return key
    }
    
    var CustomSearchJSONCx4: String {
        guard let file = self.path(forResource: "CustomSearchJSON-info", ofType: "plist") else { return "" }
        
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        
        guard let key = resource["CustomSearchJSON_CX4"] as? String else {
            fatalError("CustomSearchJSON_CX3 error")
        }
        return key
    }
}
