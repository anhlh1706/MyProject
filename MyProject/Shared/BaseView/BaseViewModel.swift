//
//  BaseViewModel.swift
//  MyProject
//
//  Created by Lê Hoàng Anh on 15/01/2022.
//  Copyright © 2022 Hoàng Anh. All rights reserved.
//

import Foundation

class BaseViewModel: NSObject {
    
    let error = ErrorTracker()
    let loading = ActivityIndicator()
    let headerLoading = ActivityIndicator()
    let footerLoading = ActivityIndicator()
    
    var currentPage = 1
    
    override init() {
        super.init()
        
        error
            .asObservable()
            .subscribe(onNext: { error in
                if let error = error as? AppError {
                    NoticeView.show(title: "Error", message: error.localizedDescription)
                } else if let error = error as? RxSwift.RxError {
                    switch error {
                    case .timeout:
                        NoticeView.show(title: "Error", message: "Không kết nối được với máy chủ vui lòng thử lại")
                    default:
                        NoticeView.show(title: "Error", message: "Unknown RxSwift error occurred")
                    }
                } else if let error = error as? Moya.MoyaError {
                    switch error {
                    case .objectMapping(_, let response), .jsonMapping(let response), .statusCode(let response):
                        if let responseError = try? response.map(ObjectResponse<NilResponse, NilResponse>.self), !responseError.isSuccess() {
                            let message = responseError.message.isNotNilAndNotEmpty ? "\(responseError.message ?? "")" : "Lỗi không xác định"
                            NoticeView.show(title: "Error", message: message)
                        } else if let responseError = try? response.map(ArrayResponse<NilResponse, NilResponse>.self), !responseError.isSuccess {
                            let message = responseError.message.isNotNilAndNotEmpty ? "\(responseError.message ?? "")" : "Lỗi không xác định"
                            NoticeView.show(title: "Error", message: message)
                        } else if let responseError = try? response.map(ObjectResponse<[NilResponse], NilResponse>.self), !responseError.isSuccess() {
                            let message = responseError.message.isNotNilAndNotEmpty ? "\(responseError.message ?? "")" : "Lỗi không xác định"
                            NoticeView.show(title: "Error", message: message)
                        } else {
                            NoticeView.show(title: "Error", message: error.localizedDescription)
                        }
                    default:
                        NoticeView.show(title: "Error", message: "Unknown Moya error occurred")
                    }
                } else {
                    NoticeView.show(title: "Error", message: error.localizedDescription)
                }
            })
            .disposed(by: rx.disposeBag)
    }
    
}

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
