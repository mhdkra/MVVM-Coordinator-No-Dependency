//
//  ProductListResponse.swift
//  MarketplaceAppTemplate
//
//  Created by Tiara Mahardika on 19/07/22.
//

import Foundation
// MARK: - ProductListResponse
struct ProductListResponse: Codable {
    let status: Int?
    let error: String?
    
    let id: Int?
    let brand: Brand?
    let name, price: String?
    let priceSign, currency: String?
    let imageLink: String?
    let productLink: String?
    let websiteLink: String?
    let movieResponseDescription: String?
    let rating: Double?
    let category: String?
    let productType: String?
    let tagList: [String]?
    let createdAt, updatedAt: String?
    let productAPIURL: String?
    let apiFeaturedImage: String?
    let productColors: [ProductColor]?

    enum CodingKeys: String, CodingKey {
        case status
        case error
        case id, brand, name, price
        case priceSign
        case currency
        case imageLink
        case productLink
        case websiteLink
        case movieResponseDescription
        case rating, category
        case productType
        case tagList
        case createdAt
        case updatedAt
        case productAPIURL
        case apiFeaturedImage
        case productColors
    }
}

enum Brand: String, Codable {
    case maybelline = "maybelline"
}

// MARK: - ProductColor
struct ProductColor: Codable {
    let hexValue: String?
    let colourName: String?

    enum CodingKeys: String, CodingKey {
        case hexValue
        case colourName
    }
}

