//
//  AuthPlugin.swift
//  MyProject
//
//  Created by Lê Hoàng Anh on 15/01/2022.
//  Copyright © 2022 Hoàng Anh. All rights reserved.
//

struct AuthPlugin: PluginType {
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        if let accessToken = UserManager.shared.accessToken {
            request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        }
        return request
    }
    
}
