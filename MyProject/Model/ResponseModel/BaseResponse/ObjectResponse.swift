//
//  ObjectResponse.swift
//  MyProject
//
//  Created by Lê Hoàng Anh on 16/01/2022.
//  Copyright © 2022 Hoàng Anh. All rights reserved.
//

struct ObjectResponse<T: Codable, U: Codable>: Codable {
    
    var code: Int?
    var message: String?
    var status: String?
    var data: T?
    var errors: U?
    var meta: Meta?
    
    enum CodingKeys: String, CodingKey {
        case code    = "status_code"
        case message
        case status
        case data
        case errors
        case meta
    }
    
    func isSuccess() -> Bool {
        return code == ApiCode.success.rawValue || code == ApiCode.createdSuccess.rawValue
    }
            
}
