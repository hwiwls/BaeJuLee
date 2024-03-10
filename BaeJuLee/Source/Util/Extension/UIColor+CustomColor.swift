//
//  UIColor+CustomColor.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/11/24.
//

import UIKit

extension UIColor {
    static let customColor = CustomColors()
    
    struct CustomColors {
        let backgroundColor = UIColor(named: "BackgroundColor") ?? .white
        let pointGreenColor = UIColor(named: "PointGreenColor") ?? .white
        let pointNavyColor = UIColor(named: "PointNavyColor") ?? .white
        let pointPinkColor = UIColor(named: "PointPinkColor") ?? .white
        let superLightGrayColor = UIColor(named: "SuperLightGrayolor") ?? .white
    }
}
