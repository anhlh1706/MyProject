//
//  UserDefault.swift
//  MyApp
//
//  Created by Lê Hoàng Anh on 17/01/2022.
//

import Foundation

@propertyWrapper struct UserDefault<Value> {
    var wrappedValue: Value? {
        get {
            let value = storage.value(forKey: key) as? Value
            return value ?? defaultValue
        }
        set {
            storage.setValue(newValue, forKey: key)
        }
    }

    private let key: String
    private let defaultValue: Value?
    private let storage: UserDefaults

    init(wrappedValue defaultValue: Value? = nil,
         key: String,
         storage: UserDefaults = .standard) {
        self.defaultValue = defaultValue
        self.key = key
        self.storage = storage
    }
}
