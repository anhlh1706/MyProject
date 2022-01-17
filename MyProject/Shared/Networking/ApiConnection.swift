//
//  ApiConnection.swift
//  Base
//
//  Created by Hoàng Anh on 30/07/2020.
//  Copyright © 2020 Hoàng Anh. All rights reserved.
//

final class ApiConnection {
    
    static let shared = ApiConnection()
    
    private let apiProvider: ApiProvider<MultiTarget>
    
    private init() {
        apiProvider = ApiProvider(plugins: [AuthPlugin()])
    }
    
}

extension ApiConnection {

    func request<T: Codable>(target: MultiTarget, type: T.Type) -> Single<T> {
        return apiProvider.request(target: target).map(T.self)
    }

    func requestArray<T: Codable>(target: MultiTarget, type: T.Type) -> Single<[T]> {
        return apiProvider.request(target: target).map([T].self)
    }
    
    func requestBaseObject<T: Codable, U: Codable>(target: MultiTarget, type: T.Type, error: U.Type) -> Single<ObjectResponse<T, U>> {
        return apiProvider.request(target: target).map(ObjectResponse<T, U>.self)
    }
    
    func requestBaseArray<T: Codable, U: Codable>(target: MultiTarget, type: T.Type, error: U.Type) -> Single<ArrayResponse<T, U>> {
        return apiProvider.request(target: target).map(ArrayResponse<T, U>.self)
    }
}
