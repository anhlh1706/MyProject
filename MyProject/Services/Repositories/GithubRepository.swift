//
//  GithubRepository.swift
//  MyProject
//
//  Created by Lê Hoàng Anh on 16/01/2022.
//  Copyright © 2022 Hoàng Anh. All rights reserved.
//

import Foundation

protocol GithubRepositoryType {
    func getRepositories(key: String) -> Single<RepositoryResponse>
}

struct GithubRepository: GithubRepositoryType {
    func getRepositories(key: String) -> Single<RepositoryResponse> {
        ApiConnection.shared.request(target: MultiTarget(ApiRouter.getRepositories(key: key)), type: RepositoryResponse.self)
    }
    
}
