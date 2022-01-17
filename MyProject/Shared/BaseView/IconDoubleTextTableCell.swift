//
//  IconDoubleTextTableCell.swift
//  MyProject
//
//  Created by Lê Hoàng Anh on 16/01/2022.
//  Copyright © 2022 Hoàng Anh. All rights reserved.
//

import UIKit

final class IconDoubleTextTableCell: UITableViewCell {
    
    private(set) var titleLabel = UILabel()
    private(set) var subtitleLabel = UILabel()
    private(set) var iconImageView = UIImageView()
    private(set) var labelStack = UIStackView()
    
    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    var subtitle: String? {
        get {
            return subtitleLabel.text
        }
        set {
            subtitleLabel.text = newValue
        }
    }
    
    var iconImage: UIImage? {
        get {
            return iconImageView.image
        }
        set {
            if iconSize == .zero {
                iconSize = CGSize(width: 40, height: 40)
            }
            iconImageView.image = newValue
        }
    }
    
    private var iconSizeAnchor: ConstraintPair!
    
    var iconSize: CGSize = .zero {
        didSet {
            removeConstraint(iconSizeAnchor.first)
            removeConstraint(iconSizeAnchor.second)
            iconSizeAnchor.first.constant = iconSize.width
            iconSizeAnchor.second.constant = iconSize.height
        }
    }
    
    var iconCornerRadius: CGFloat = 0 {
        didSet {
            iconImageView.cornerRadius = iconCornerRadius
        }
    }
    
    func render(title: String, subtitle: String? = nil, icon: UIImage? = nil, iconUrl: String? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.iconImage = icon
        if let iconUrl = iconUrl {
            iconImageView.sd_setImage(with: URL(string: iconUrl), placeholderImage: icon, completed: { (image, _, _, _) in
                self.iconImage = image
            })
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        addSubview(iconImageView)
        iconSizeAnchor = (iconImageView.sizeAnchors == CGSize(width: 0, height: 0))
        iconImageView.verticalAnchors >= verticalAnchors + 8
        iconImageView.leadingAnchor == leadingAnchor + 16
        iconImageView.centerYAnchor == centerYAnchor
        
        addSubview(labelStack)
        [titleLabel, subtitleLabel].forEach { view in
            labelStack.addArrangedSubview(view)
        }
        
        labelStack.axis = .vertical
        labelStack.spacing = 3
        
        labelStack.leadingAnchor == iconImageView.trailingAnchor + 10
        labelStack.topAnchor == topAnchor + 10
        labelStack.bottomAnchor <= bottomAnchor - 8
        labelStack.trailingAnchor == trailingAnchor - 20
        
        iconImageView.contentMode = .scaleAspectFit
        
        titleLabel.numberOfLines = 0
        subtitleLabel.numberOfLines = 0
        
        titleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        subtitleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        
        titleLabel.textColor = .text
        subtitleLabel.textColor = .subtext
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
