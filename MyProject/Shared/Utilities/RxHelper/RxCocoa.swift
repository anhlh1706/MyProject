//
//  RxCocoa.swift
//  MyProject
//
//  Created by Lê Hoàng Anh on 16/01/2022.
//  Copyright © 2022 Hoàng Anh. All rights reserved.
//

import Foundation

extension SharedSequenceConvertibleType where Element == Bool {
    /// Boolean not operator.
    public func not() -> SharedSequence<SharingStrategy, Bool> {
        return map(!)
    }
}

extension Reactive where Base: UIScrollView {
    /**
     Shows if the bottom of the UIScrollView is reached.
     - parameter offset: A threshhold indicating the bottom of the UIScrollView.
     - returns: ControlEvent that emits when the bottom of the base UIScrollView is reached.
     */
    func reachedBottom(offset: CGFloat = 0.0) -> ControlEvent<Void> {
        let source = contentOffset.map { contentOffset in
            let visibleHeight = self.base.frame.height - self.base.contentInset.top - self.base.contentInset.bottom
            let y = contentOffset.y + self.base.contentInset.top
            let threshold = max(offset, self.base.contentSize.height - visibleHeight)
            return y >= threshold
        }
        .distinctUntilChanged()
        .filter { $0 }
        .map { _ in () }
        return ControlEvent(events: source)
    }
}

extension SharedSequence {

    /**
     Takes a SharedSequence of optional elements and returns a SharedSequence of non-optional elements, filtering out any nil values.

     - returns: A SharedSequence of non-optional elements
     */

    func unwrap<Result>() -> SharedSequence<SharingStrategy, Result> where Element == Result? {
        return self.filter { $0 != nil }.map { $0! }
    }
}
