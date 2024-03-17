//
//  CalendarCollectionViewCell.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/15/24.
//

import UIKit
import SnapKit
import Then
import FSCalendar

class CalendarCollectionViewCell: BaseCollectionViewCell {
    
    lazy var calendar = FSCalendar().then {
        $0.scope = .week
        $0.backgroundColor = .pointBackground
        $0.locale = Locale(identifier: "ko_KR")
        $0.appearance.todayColor = .pointGreen
        $0.appearance.titleTodayColor = .white
        $0.appearance.weekdayTextColor = .black
        $0.appearance.selectionColor = .pointPink
        $0.headerHeight = 0
        $0.weekdayHeight = 48
        $0.backgroundColor = .clear
        $0.scrollEnabled = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .pointBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configHierarchy() {
        self.addSubview(calendar)
    }
    
    override func configLayout() {
        
        calendar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
    }
}
