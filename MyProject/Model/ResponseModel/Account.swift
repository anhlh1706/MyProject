//
//  Account.swift
//  Base
//
//  Created by Lê Hoàng Anh on 04/08/2020.
//  Copyright © 2020 Hoàng Anh. All rights reserved.
//

import Foundation

struct Account: Decodable {
    let accessToken: String
    let tokenType: String
    let refreshToken: String
    let expiresIn: String
    var info: AccountInfo?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "accessToken"
        case tokenType = "tokenType"
        case refreshToken = "refreshToken"
        case expiresIn = "expiresIn"
    }
}

struct AccountInfo: Decodable {
    let email: String?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
    }
}
