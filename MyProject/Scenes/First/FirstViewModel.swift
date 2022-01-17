//
//  FirstViewModel.swift
//  MyProject
//
//  Created by Lê Hoàng Anh on 16/01/2022.
//  Copyright © 2022 Hoàng Anh. All rights reserved.
//

extension FirstViewController {
    final class ViewModel: BaseViewModel {
        
        let repo: GithubRepositoryType
        
        override init() {
            repo = GithubRepository()
        }
        
    }
}

extension FirstViewController.ViewModel: ViewModelType {
    func transform(_ input: Input) -> Output {
        let dataResponse = input.searchKey.flatMapLatest { key -> Driver<[Repository]> in
            return self.repo.getRepositories(key: key)
                .map(\.items)
                .asDriver(onErrorJustReturn: [])
        }
        return Output(dataResponse: dataResponse)
    }
    
    struct Input {
        let searchKey: Driver<String>
    }
    
    struct Output {
        let dataResponse: Driver<[Repository]>
    }
}
