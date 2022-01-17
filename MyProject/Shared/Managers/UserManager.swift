//
//  UserManager.swift
//  Base
//
//  Created by Lê Hoàng Anh on 04/08/2020.
//  Copyright © 2020 Hoàng Anh. All rights reserved.
//

import KeychainAccess

final class UserManager {
    
    private var account: Account?
    var accountInfo: AccountInfo? {
        account?.info
    }
    
    var tokenType: String {
        account?.tokenType ?? ""
    }
    
    var accessToken: String? {
        account?.accessToken
    }
    
    var refreshToken: String {
        account?.refreshToken ?? ""
    }
    
    var isLogedIn: Bool {
        Keychain(service: kAppService).getValue(kAccessToken) != nil
    }
    
    private init() {
        loadAccount()
    }
    
    static let shared = UserManager()
    
    func loadAccount() {
        let keychain = Keychain(service: kAppName)
        
        guard
            let accessToken =   keychain.getValue(kAccessToken),
            let tokenType =     keychain.getValue(kTokenType),
            let refreshToken =  keychain.getValue(kRefreshToken),
            let expiresIn =     keychain.getValue(kExpiresIn)
            else {
                account = nil
                return
        }
        
        account = Account(accessToken:  accessToken,
                          tokenType:    tokenType,
                          refreshToken: refreshToken,
                          expiresIn:    expiresIn)
        
    }
    
    func save(account: Account) {
        let keychain = Keychain(service: kAppService)
        
        keychain.setOrRemove(account.accessToken,  key: kAccessToken)
        keychain.setOrRemove(account.tokenType,    key: kTokenType)
        keychain.setOrRemove(account.expiresIn,    key: kRefreshToken)
        keychain.setOrRemove(account.refreshToken, key: kExpiresIn)
        
        loadAccount()
    }
    
    func save(info: AccountInfo) {
        let keychain = Keychain(service: kAppService)
        keychain.setOrRemove(info.email,  key: kEmail)
        account?.info = info
    }
    
    func save(deviceToken token: String) {
        return Keychain(service: kAppService).setOrRemove(token, key: kDeviceToken)
    }
    
    func logOut() {
        try? Keychain(service: kAppService).removeAll()
        loadAccount()
        deleteCookies()
    }
    
    func isExpiredToken() -> Bool {
        if let expiresIn = account?.expiresIn {
            return DateFormatter.fullStyle().date(from: expiresIn)?.compare(Date()) != .orderedDescending
        }
        return true
    }
    
    func saveCookies() {
        guard let rootObject = HTTPCookieStorage.shared.cookies else {
            return
        }
        
        let cookiesData = try? NSKeyedArchiver.archivedData(withRootObject: rootObject, requiringSecureCoding: true)
        UserDefaults.standard.set(cookiesData, forKey: kAppStorageCookie)
    }
    
    func loadCookies() {
        guard let cookiesData = UserDefaults.standard.data(forKey: kAppStorageCookie) else {
            return
        }
        
        if let data = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(cookiesData) as? [HTTPCookie] {
            data.forEach {
                HTTPCookieStorage.shared.setCookie($0)
            }
        }
    }
    
    func deleteCookies() {
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        
        guard let cookies = HTTPCookieStorage.shared.cookies else {
            return
        }
        
        for obj in cookies {
            HTTPCookieStorage.shared.deleteCookie(obj)
        }
        UserDefaults.standard.removeObject(forKey: kAppStorageCookie)
    }
    
}
