/// Bym

import UIKit

extension UILabel {
    convenience init(text: String? = "", font: UIFont = .systemFont(ofSize: 17), color: UIColor = .text, textAlignment: NSTextAlignment = .left) {
        self.init()
        self.text = text
        self.font = font
        textColor = color
        self.textAlignment = textAlignment
    }
}

final class Label: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .text
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    @IBInspectable
//    var localizeText: String = "" {
//        didSet {
//            text = localizeText.localized
//        }
//    }
    
    @IBInspectable
    var isStrikethrough: Bool = false {
        didSet {
            styleText()
        }
    }
    
    @IBInspectable
    var isUnderlined: Bool = false {
        didSet {
            styleText()
        }
    }
    
    @IBInspectable
    var spacing: Float = 0.0 {
        didSet {
            styleText()
        }
    }
    
    @IBInspectable
    var linedSpacing: CGFloat = 1 {
        didSet {
            styleText()
        }
    }
    
    override var text: String? {
        didSet {
            super.text = text
            styleText()
        }
    }
    
    override func awakeFromNib() {
        if (text ?? "").isEmpty {
            styleText()
        }
    }
    
    private func styleText() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = linedSpacing
        paragraphStyle.alignment = textAlignment
        
        var attributes: [NSAttributedString.Key: Any] = [
            .kern: spacing,
            .paragraphStyle: paragraphStyle,
            .foregroundColor: textColor as Any,
            .font: font as Any,
            .strikethroughStyle: isStrikethrough ? 1 : 0
        ]
        if isUnderlined {
            attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
        }
        
        let attributedString = NSAttributedString(string: text ?? "", attributes: attributes)
        
        attributedText = attributedString
    }
}
