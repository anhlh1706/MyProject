//
//  ApiRouter.swift
//  MyProject
//
//  Created by Lê Hoàng Anh on 16/01/2022.
//  Copyright © 2022 Hoàng Anh. All rights reserved.
//

import Foundation

enum ApiRouter {
    case getRepositories(key: String)
}

extension ApiRouter: TargetType {
    
    var baseURL: URL {
        switch self {
        case .getRepositories:
            return URL(string: Config.shared.baseApiUrl)!
        }
    }
    
    var path: String {
        switch self {
        case .getRepositories:
            return "/search/repositories"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRepositories:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getRepositories:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var parameters: [String: Any] {
        var params = [String: Any]()
        switch self  {
        case .getRepositories(let key):
            params["q"] = key
        }
        return params
    }
    
}
