//
//  IconTextTableCell.swift
//  MyProject
//
//  Created by Lê Hoàng Anh on 16/01/2022.
//  Copyright © 2022 Hoàng Anh. All rights reserved.
//

import Foundation

final class IconTextTableCell: TableViewCell {
    
    private(set) var titleLabel: Label!
    private(set) var iconImageView: UIImageView!
    
    private var topSpacingConstraint: NSLayoutConstraint!
    private var bottomSpacingConstraint: NSLayoutConstraint!
    private var iconWidth: NSLayoutConstraint!
    private var iconHeight: NSLayoutConstraint!
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var icon: UIImage? {
        didSet {
            iconImageView.image = icon
        }
    }
    
    var verticalSpacing: CGFloat = 12 {
        didSet {
            topSpacing = verticalSpacing
            bottomSpacing = verticalSpacing
        }
    }
    
    var topSpacing: CGFloat = 12 {
        didSet {
            topSpacingConstraint.constant = topSpacing
        }
    }
    
    var bottomSpacing: CGFloat = 12 {
        didSet {
            bottomSpacingConstraint.constant = -bottomSpacing
        }
    }
    
    var iconSize: CGSize = CGSize(width: 30, height: 30) {
        didSet {
            iconWidth.constant = iconSize.width
            iconHeight.constant = iconSize.height
        }
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        verticalSpacing = 12
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        titleLabel = Label()
        
        contentView.addSubview(titleLabel)
        titleLabel.leadingAnchor == contentView.leadingAnchor + 66
        titleLabel.trailingAnchor == contentView.trailingAnchor - 16
        
        topSpacingConstraint = titleLabel.topAnchor == contentView.topAnchor + 12
        bottomSpacingConstraint = titleLabel.bottomAnchor == contentView.bottomAnchor - 12
        
        iconImageView = UIImageView()
        contentView.addSubview(iconImageView)
        iconWidth = iconImageView.widthAnchor == 30
        iconHeight = iconImageView.heightAnchor == 30
        iconImageView.leadingAnchor == contentView.leadingAnchor + 20
        iconImageView.centerYAnchor == titleLabel.centerYAnchor
        
        titleLabel.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
