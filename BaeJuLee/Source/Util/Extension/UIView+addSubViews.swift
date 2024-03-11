//
//  UIView+addSubViews.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/12/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            addSubview($0)
        }
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
