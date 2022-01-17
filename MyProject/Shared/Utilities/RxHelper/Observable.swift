//
//  Observable.swift
//  MyProject
//
//  Created by Lê Hoàng Anh on 16/01/2022.
//  Copyright © 2022 Hoàng Anh. All rights reserved.
//

extension ObservableType {

    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }
    
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
    
    func unwrap<Result>() -> Observable<Result> where Element == Result? {
        return compactMap { $0 }
    }
    
}

extension ObservableType where Element == Bool {
    
    func not() -> Observable<Bool> {
        return map(!)
    }
    
}

extension ControlPropertyType where Element == String? {
    var isNotNilAndEmpty: Driver<String> {
        return orEmpty.asDriver()
    }
}
