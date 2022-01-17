//
//  Environment.swift
//  MyProject
//
//  Created by Lê Hoàng Anh on 16/01/2022.
//  Copyright © 2022 Hoàng Anh. All rights reserved.
//

import Foundation

enum Environment {
    case dev
    case product
    
    var baseUrl: String {
        switch self {
        case .dev:
            return "https://api.github.com"
        case .product:
            return "https://api.github.com"
        }
    }
}

