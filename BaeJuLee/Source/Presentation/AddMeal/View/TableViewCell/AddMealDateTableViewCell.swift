//
//  AddMealDateTableViewCell.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/18/24.
//

import UIKit
import SnapKit
import Then

// TODO: 나중에 테이블뷰 셀로 이용
final class AddMealDateTableViewCell: BaseTableViewCell {
    let dateView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }

    let dateLabel = UILabel().then {
        let dateString = DateFormatterUtility.shared.string(from: Date(), withFormat: "yyyy년 MM월 dd일")
        $0.text = dateString
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
    }

    let datePicker = UIDatePicker().then {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .wheels
        $0.locale = Locale(identifier: "ko-KR")
    }

    let dateChevronBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysOriginal).withTintColor(.pointRegularLightGray), for: .normal)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configHierarchy() {
        self.addSubview(dateView)
        
        dateView.addSubviews([
            dateLabel,
            dateChevronBtn
        ])
    }
    
    override func configLayout() {
        dateView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        dateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(200)
        }

        dateChevronBtn.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(20)
        }
    }
    
    override func configView() {
        backgroundColor = .clear
    }

}
