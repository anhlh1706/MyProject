//
//  RepositoryType.swift
//  MyProject
//
//  Created by Lê Hoàng Anh on 16/01/2022.
//  Copyright © 2022 Hoàng Anh. All rights reserved.
//

typealias StringResponseSingle = Single<ObjectResponse<StringResponse, NilResponse>>
typealias StringResponseDriver = Driver<ObjectResponse<StringResponse, NilResponse>>

typealias ObjectResponseSingle<T> = Single<ObjectResponse<T, NilResponse>> where T: Codable
typealias ArrayResponseSingle<T> = Single<ArrayResponse<T, NilResponse>> where T: Codable
typealias ObjectResponseDriver<T> = Driver<ObjectResponse<T, NilResponse>> where T: Codable
typealias ArrayResponseDriver<T> = Driver<ArrayResponse<T, NilResponse>> where T: Codable
