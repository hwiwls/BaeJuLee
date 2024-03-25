//
//  Search.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/24/24.
//

import Foundation

// MARK: - Search
struct Search: Decodable {
    let items: [Item]
}

// MARK: - Item
struct Item: Decodable {
    let title: String
    let link: String
    let pagemap: Pagemap
}

// MARK: - Pagemap
struct Pagemap: Decodable {
    let cseImage: [CSEImage]

    enum CodingKeys: String, CodingKey {
        case cseImage = "cse_image"
    }
}

// MARK: - CSEImage
struct CSEImage: Decodable {
    let src: String
}
