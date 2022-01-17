//
//  Button.swift
//  Base
//
//  Created by Hoàng Anh on 30/07/2020.
//  Copyright © 2020 Hoàng Anh. All rights reserved.
//

import UIKit

class Button: UIButton {
    
    @IBInspectable var localizeTitle: String = "" {
        didSet {
            setTitle(localizeTitle.localized, for: .normal)
        }
    }
    
    @IBInspectable
    var spacing: Float = 0.0 {
        didSet {
            setTitle(currentTitle, for: .normal)
        }
    }
    
    @IBInspectable
    var isUnderlined: Bool = false {
        didSet {
            setTitle(currentTitle, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(.primary, for: .normal)
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        
        var attributes: [NSAttributedString.Key: Any] = [
            .kern: spacing,
            .foregroundColor: titleColor(for: .normal) as Any,
            .font: titleLabel?.font as Any
        ]
        if isUnderlined {
            attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
        }
        
        let attributedString = NSAttributedString(string: currentTitle ?? "", attributes: attributes)
        setAttributedTitle(attributedString, for: state)
    }
    
    override func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        super.setTitleColor(color, for: state)
        setTitle(currentTitle, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

final class RoundedButton: Button {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitleColor(.white, for: .normal)
        backgroundColor = .primary
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class OutlinedButton: Button {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(.primary, for: .normal)
        layer.borderWidth = 1
        layer.borderColor = UIColor.primary.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
