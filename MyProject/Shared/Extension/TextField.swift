//
//  TextField.swift
//  Base
//
//  Created by Hoàng Anh on 12/08/2020.
//  Copyright © 2020 Hoàng Anh. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setLeftPadding(_ padding: CGFloat) {
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 0))
        leftViewMode = .always
    }
}
