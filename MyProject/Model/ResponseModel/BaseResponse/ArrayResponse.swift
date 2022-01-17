//
//  ArrayResponse.swift
//  MyProject
//
//  Created by Lê Hoàng Anh on 16/01/2022.
//  Copyright © 2022 Hoàng Anh. All rights reserved.
//

import Foundation

struct ArrayResponse<T: Codable, U: Codable>: Codable, Pagingable {
    
    var code: Int?
    var message: String?
    var status: String?
    var data: [T]?
    var errors: U?
    var meta: Meta?
         
    enum CodingKeys: String, CodingKey {
        case code    =  "status_code"
        case message
        case status
        case data
        case errors
        case meta
    }
    
    var isSuccess: Bool {
        code == ApiCode.success.rawValue || code == ApiCode.createdSuccess.rawValue
    }
    
    var hasNext: Bool {
        guard let currentPage = meta?.pagination?.currentPage, let totalPage = meta?.pagination?.totalPages else {
            return false
        }
        return currentPage < totalPage
    }
    
}
