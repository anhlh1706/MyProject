//
//  TitleTextView.swift
//  MyApp
//
//  Created by Lê Hoàng Anh on 17/11/2020.
//

import UIKit
import Anchorage

final class TitleTextView: UIView {
    
    private(set) var titleLabel: UILabel!
    
    private(set) var textView: SizingTextView!
    
    private(set) var placeholderLabel: UILabel!
    
    var placeholder: String = "" {
        didSet {
            placeholderLabel.text = placeholder
            textView.placeholder = placeholder
        }
    }
    
    var minHeight: CGFloat = 0 {
        didSet {
            textView.minHeight = minHeight
        }
    }
    
    private var containerView: UIView!
    
    var content: String {
        textView.text ?? ""
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel = UILabel()
        
        addSubview(titleLabel)
        titleLabel.topAnchor == topAnchor + 6
        titleLabel.horizontalAnchors == horizontalAnchors
        
        containerView = UIView()
        
        addSubview(containerView)
        containerView.topAnchor == titleLabel.bottomAnchor + 6
        containerView.horizontalAnchors == horizontalAnchors
        containerView.bottomAnchor == bottomAnchor - 1
        
        textView = SizingTextView()
        
        containerView.addSubview(textView)
        textView.edgeAnchors == containerView.edgeAnchors + UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 4)
        
        placeholderLabel = UILabel()
        
        containerView.addSubview(placeholderLabel)
        placeholderLabel.topAnchor == textView.topAnchor + 7
        placeholderLabel.horizontalAnchors == textView.horizontalAnchors + 5
        
        titleLabel.font = .systemFont(ofSize: 15)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 9
        
        textView.typingAttributes = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: 15),
            .foregroundColor: UIColor.black,
        ]
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 7
        containerView.layer.masksToBounds = true
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.black.withAlphaComponent(0.12).cgColor
        
        placeholderLabel.textColor = UIColor.black.withAlphaComponent(0.3)
        placeholderLabel.numberOfLines = 0
        placeholderLabel.font = .systemFont(ofSize: 13)
        
        textView.rx.didChange.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.placeholderLabel.isHidden = !self.textView.text.isEmpty
        }).disposed(by: rx.disposeBag)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.placeholderLabel.isHidden = !self.textView.text.isEmpty
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class SizingTextView: UITextView {
    
    var placeholder: String = ""
    
    var minHeight: CGFloat = 50
    
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        let placeholderHeight = AppHelper.estimatedHeight(ofString: placeholder, withFont: font ?? .systemFont(ofSize: 13), lineWidth: bounds.width - 14)
        return CGSize(width: UIView.noIntrinsicMetric, height: max(contentSize.height + 20, placeholderHeight + 20, minHeight))
    }
}
