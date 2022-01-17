//
//  Pagination.swift
//  MyProject
//
//  Created by Lê Hoàng Anh on 16/01/2022.
//  Copyright © 2022 Hoàng Anh. All rights reserved.
//

struct Meta: Codable {
    
    var pagination: Pagination?
    
    enum CodingKeys: String, CodingKey {
        case pagination = "pagination"
    }
    
}


struct Pagination: Codable {
    
    var total: Int?
    var count: Int?
    var perPage: Int?
    var currentPage: Int?
    var totalPages: Int?
    var links: PaginationLinks?
    
    enum CodingKeys: String, CodingKey {
        case total = "total"
        case count = "count"
        case perPage = "per_page"
        case currentPage = "current_page"
        case totalPages = "total_pages"
        case links = "links"
    }
    
}

struct PaginationLinks: Codable {
    
    var next: String?
    
    enum CodingKeys: String, CodingKey {
        case next = "next"
    }
    
}
