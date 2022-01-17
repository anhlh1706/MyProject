//
//  UIViewController.swift
//  Base
//
//  Created by Lê Hoàng Anh on 10/12/2020.
//  Copyright © 2020 Hoàng Anh. All rights reserved.
//

import UIKit
import Anchorage

extension UIViewController {
    
    func showLoading(in view: UIView? = nil, text: String = "Loading", style: LoadingView.Style = .clear) {
        let loadingView = LoadingView(text: text, style: style)
        loadingView.alpha = 0
        
        if let view = view {
            view.addSubview(loadingView)
            loadingView.edgeAnchors == view.edgeAnchors
        } else if let keyWindow = AppDelegate.shared.window {
            keyWindow.addSubview(loadingView)
            loadingView.edgeAnchors == keyWindow.edgeAnchors
        }
        UIView.animate(withDuration: 0.1) {
            loadingView.alpha = 1
        }
    }
    
    func hideLoading(for view: UIView? = nil) {
        var loadingViews = [UIView]()
        
        if let view = view {
            loadingViews = view.subviews.filter { $0 is LoadingView }
        } else if let views = AppDelegate.shared.window?.subviews.filter({ $0 is LoadingView }) {
            loadingViews = views
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            UIView.animate(withDuration: 0.1, animations: {
                loadingViews.forEach { $0.alpha = 0 }
            }) { _ in
                loadingViews.forEach { $0.removeFromSuperview() }
            }
        })
    }
}
