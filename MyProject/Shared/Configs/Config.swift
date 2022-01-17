//
//  Config.swift
//  Base
//
//  Created by Lê Hoàng Anh on 04/08/2020.
//  Copyright © 2020 Hoàng Anh. All rights reserved.
//

import Foundation

final class Config {
    
    var baseApiUrl: String {
        env.baseUrl
    }
    
    static let shared = Config()
    
    var env: Environment {
        #if DEBUG
            return .product
        #elseif STAGING
            return .dev
        #elseif RELEASE
            return .product
        #endif
    }
    
}
