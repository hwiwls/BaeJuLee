//
//  CustomFSCalendarCell.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/26/24.
//

import FSCalendar

class CustomFSCalendarCell: FSCalendarCell {
    override func layoutSubviews() {
        super.layoutSubviews()

        let diameter: CGFloat = max(self.bounds.size.width, self.bounds.size.height) * 0.4
        self.shapeLayer.frame = CGRect(x: (self.bounds.size.width - diameter) / 2,
                                        y: (self.bounds.size.height - diameter) / 2,
                                        width: diameter, height: diameter)

        let path = UIBezierPath(roundedRect: self.shapeLayer.bounds, cornerRadius: diameter / 2).cgPath
        if self.shapeLayer.path != path {
            self.shapeLayer.path = path
        }
    }

}
