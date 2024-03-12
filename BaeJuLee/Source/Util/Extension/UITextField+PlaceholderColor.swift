//
//  UITextField+PlaceholderColor.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/12/24.
//

import UIKit

extension UITextField {
    func setPlaceholder(color: UIColor) {
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
}
