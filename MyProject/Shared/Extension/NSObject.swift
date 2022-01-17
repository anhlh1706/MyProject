//
//  NSObject.swift
//  MyProject
//
//  Created by Lê Hoàng Anh on 16/01/2022.
//  Copyright © 2022 Hoàng Anh. All rights reserved.
//

extension NSObject {
    
    /**
     Get the identifier of object.

     - Returns: Identifier of object in string.
     */
    class func identifier() -> String {
        NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }

    func identifier() -> String {
        NSStringFromClass(classForCoder).components(separatedBy: ".").last ?? ""
    }
}
