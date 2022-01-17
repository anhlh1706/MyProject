//
//  ErrorTracker.swift
//  MyProject
//
//  Created by Lê Hoàng Anh on 16/01/2022.
//  Copyright © 2022 Hoàng Anh. All rights reserved.
//

enum AppError: LocalizedError {
    
    case customErrror(message: String)
    
    var localizedDescription: String {
        switch self {
        case .customErrror(let message):
            return message
        }
    }
    
}

final class ErrorTracker: SharedSequenceConvertibleType {
    
    typealias SharingStrategy = DriverSharingStrategy
    
    private let _subject = PublishSubject<Error>()

    func trackError<O: ObservableConvertibleType>(from source: O) -> Observable<O.Element> {
        return source.asObservable().do(onNext: { (element) in
            if let elementError = element as? ObjectResponse<NilResponse, NilResponse>, !elementError.isSuccess() {
                let message = elementError.message.isNotNilAndNotEmpty ? "\(elementError.message ?? "")" : "Lỗi không xác định"
                self.onError(message)
            }
            if let elementError = element as? ObjectResponse<[NilResponse], NilResponse>, !elementError.isSuccess() {
                let message = elementError.message.isNotNilAndNotEmpty ? "\(elementError.message ?? "")" : "Lỗi không xác định"
                self.onError(message)
            }
            if let elementError = element as? ArrayResponse<NilResponse, NilResponse>, !elementError.isSuccess {
                let message = elementError.message.isNotNilAndNotEmpty ? "\(elementError.message ?? "")" : "Lỗi không xác định"
                self.onError(message)
            }
        }, onError: { (error) in
            self.onError(error)
        })
    }
    
    func trackError<O: ObservableConvertibleType, T: Codable, U: Codable>(from source: O, type: T.Type, error: U.Type) -> Observable<O.Element> {
        return source.asObservable().do(onNext: { (element) in
            if let elementError = element as? ObjectResponse<T, U>, !elementError.isSuccess() {
                let message = elementError.message.isNotNilAndNotEmpty ? "\(elementError.message ?? "")" : "Lỗi không xác định"
                self.onError(message)
            }
            if let elementError = element as? ObjectResponse<[T], U>, !elementError.isSuccess() {
                let message = elementError.message.isNotNilAndNotEmpty ? "\(elementError.message ?? "")" : "Lỗi không xác định"
                self.onError(message)
            }
            if let elementError = element as? ArrayResponse<T, U>, !elementError.isSuccess {
                let message = elementError.message.isNotNilAndNotEmpty ? "\(elementError.message ?? "")" : "Lỗi không xác định"
                self.onError(message)
            }
        }, onError: { (error) in
            self.onError(error)
        })
    }
        
    func asSharedSequence() -> SharedSequence<SharingStrategy, Error> {
        return _subject.asObservable().asDriverOnErrorJustComplete()
    }

    func asObservable() -> Observable<Error> {
        return _subject.asObservable()
    }

    private func onError(_ error: Error) {
        _subject.onNext(error)
    }

    private func onError(_ error: String) {
        let error = AppError.customErrror(message: error)
        _subject.onNext(error)
    }
    
    deinit {
        _subject.onCompleted()
    }
}
