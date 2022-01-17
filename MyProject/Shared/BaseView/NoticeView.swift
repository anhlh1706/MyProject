//
//  NoticeView.swift
//  MyProject
//
//  Created by Lê Hoàng Anh on 10/05/2021.
//  Copyright © 2022 Hoàng Anh. All rights reserved.
//

final class NoticeView: UIView {
    
    var title = "Thông báo" {
        didSet {
            titleLabel?.text = title
        }
    }
    
    var message = "" {
        didSet {
            messageLabel?.text = message
        }
    }
    
    private var roundView: UIView!
    private var cancelButton: UIButton!
    
    private(set) var stack: UIStackView!
    private(set) var titleLabel: Label!
    private(set) var messageLabel: Label!
    private(set) var button: RoundedButton!
    
    var action: (() -> Void)?
    var cancelAction: (() -> Void)?
    
    var showCancelButton = false
    
    init(title: String = "Thông báo", message: String, showCancelButton: Bool = false) {
        self.title = title
        self.message = message
        self.showCancelButton = showCancelButton
        super.init(frame: .zero)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .clear
        
        titleLabel = Label(font: .systemFont(ofSize: 19, weight: .semibold))
        messageLabel = Label(font: .systemFont(ofSize: 16))
        button = RoundedButton()
        
        if showCancelButton {
            cancelButton = UIButton()
            
            cancelButton.setTitle("Không", for: .normal)
            cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
            
            let buttonStack = UIStackView(arrangedSubviews: [cancelButton, button])
            buttonStack.axis = .horizontal
            buttonStack.spacing = 10
            buttonStack.distribution = .fillEqually
            stack = UIStackView(arrangedSubviews: [titleLabel, messageLabel, buttonStack])
            
            buttonStack.heightAnchor == 42
            buttonStack.widthAnchor == stack.widthAnchor
        } else {
            stack = UIStackView(arrangedSubviews: [titleLabel, messageLabel, button])
        }
        
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        stack.setCustomSpacing(20, after: messageLabel)
        
        [titleLabel, messageLabel].forEach {
            $0?.textAlignment = .center
        }
        
        messageLabel.alpha = 0.7
        messageLabel.numberOfLines = 0
        
        button.setTitle("Đồng ý", for: .normal)
        button.addTarget(self, action: #selector(executeAction), for: .touchUpInside)
        
        roundView = UIView()
        roundView.backgroundColor = .white
        
        roundView.layer.cornerRadius = 20
        roundView.layer.masksToBounds = true
        
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        messageLabel.text = message
        
        roundView.addSubview(stack)
        stack.edgeAnchors == roundView.edgeAnchors + UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        
        if !showCancelButton {
            button.sizeAnchors == CGSize(width: 146, height: 42)
        }
        
        addSubview(roundView)
        roundView.centerAnchors == centerAnchors
        roundView.leadingAnchor == leadingAnchor + 24
        roundView.verticalAnchors == verticalAnchors
        
        button.cornerRadius = 21
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        
        cancelButton?.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        cancelButton?.cornerRadius = 21
        cancelButton?.setTitleColor(.primary, for: .normal)
        cancelButton?.backgroundColor = .clear
    }
    
    @objc
    func executeAction() {
        action?()
    }
    
    @objc func cancelButtonPressed() {
        cancelAction?()
    }
}

extension NoticeView {
    
    static func show(title: String = "Thông báo",
                     message: String,
                     actionTitle: String = "Đồng ý",
                     cancelActionTitle: String? = nil,
                     leftAction: (() -> Void)? = nil,
                     action: (() -> Void)? = nil) {
        DispatchQueue.main.async(execute: {
            show(title: title,
                 message: message,
                 attributeMessage: nil,
                 actionTitle: actionTitle,
                 cancelActionTitle: cancelActionTitle,
                 action: action,
                 leftAction: leftAction)
        })
        
    }
    
    static func show(title: String = "Thông báo",
                     attributedMessage: NSAttributedString,
                     actionTitle: String = "Đồng ý",
                     cancelActionTitle: String? = nil,
                     action: (() -> Void)? = nil) {
        DispatchQueue.main.async(execute: {
            show(title: title, message: "", attributeMessage: attributedMessage, actionTitle: actionTitle, cancelActionTitle: cancelActionTitle, action: action)
        })
    }
    
    static private func show(title: String,
                             message: String,
                             attributeMessage: NSAttributedString? = nil,
                             actionTitle: String,
                             cancelActionTitle: String? = nil,
                             action: (() -> Void)? = nil,
                             leftAction: (() -> Void)? = nil) {
        
        guard let window = AppDelegate.shared.window else {
            return
        }
        
        if window.subviews.contains(where: { $0 is NoticeView }) {
            return
        }
        
        let darkView = UIView()
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0)
        window.addSubview(darkView)
        darkView.edgeAnchors == window.edgeAnchors
        
        let showCancelButton = cancelActionTitle != nil
        let noticeView = NoticeView(title: title, message: message, showCancelButton: showCancelButton)
        
        if let attributed = attributeMessage {
            noticeView.messageLabel.text = ""
            noticeView.messageLabel.attributedText = attributed
        }
        
        noticeView.button.setTitle(actionTitle, for: .normal)
        
        noticeView.cancelButton?.setTitle(cancelActionTitle, for: .normal)
        
        darkView.addSubview(noticeView)
        noticeView.centerAnchors == darkView.centerAnchors
        noticeView.leadingAnchor == darkView.leadingAnchor
        
        noticeView.transform = CGAffineTransform(translationX: 0, y: 200)
        noticeView.alpha = 0
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseIn) {
            darkView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            noticeView.transform = .identity
            noticeView.alpha = 1
        }
        
        noticeView.action = {
            disappear()
            action?()
        }
        
        noticeView.cancelAction = {
            disappear()
            leftAction?()
        }
        
        func disappear() {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
                darkView.backgroundColor = UIColor.black.withAlphaComponent(0)
                noticeView.transform = CGAffineTransform(translationX: 0, y: 200)
                noticeView.alpha = 0
            } completion: { _ in
                darkView.removeFromSuperview()
                noticeView.removeFromSuperview()
            }
        }
    }
}
