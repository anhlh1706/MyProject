//
//  User.swift
//  Base
//
//  Created by Hoàng Anh on 31/07/2020.
//  Copyright © 2020 Hoàng Anh. All rights reserved.
//

import Foundation

struct RepositoryResponse: Codable {
    let totalCount: Int
    let items: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items = "items"
    }
}

struct Repository: Codable {
    let name: String
    let fullname: String
    let owner: User
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case fullname = "full_name"
        case owner = "owner"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        fullname = try values.decode(String.self, forKey: .fullname)
        owner = try values.decode(User.self, forKey: .owner)
    }
}

extension Repository: Equatable {
    static func == (lhs: Repository, rhs: Repository) -> Bool {
        lhs.fullname.elementsEqual(rhs.fullname)
    }
}

struct User: Codable {
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        avatarUrl = try values.decode(String.self, forKey: .avatarUrl)
    }
}
