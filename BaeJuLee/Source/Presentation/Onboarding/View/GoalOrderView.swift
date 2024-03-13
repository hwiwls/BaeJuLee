//
//  GoalOrderCntView.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/12/24.
//

import UIKit
import SnapKit
import Then

final class GoalOrderView: BaseView {
    
    private let goalOrderTitleLabel = UILabel().then {
        $0.text = "앞으로의 목표를 알려주세요!"
        $0.font = .boldSystemFont(ofSize: 25)
        $0.textColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    
    private let goalOrderCntTitleLabel = UILabel().then {
        $0.text = "목표 배달 횟수"
        $0.font = .boldSystemFont(ofSize: 15)
        $0.textColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    
    let goalOrderCntTextField = UITextField().then {
        $0.placeholder = "횟수"
        $0.backgroundColor = .clear
        $0.textColor = .black
        $0.keyboardType = .numberPad
        $0.setPlaceholder(color: .pointRegularLightGray)
    }
    
    private let textfieldBorderView01 = UIView().then {
        $0.backgroundColor = .pointRegularLightGray
    }
    
//    private let goalOrderPriceTitleLabel = UILabel().then {
//        $0.text = "목표 배달 지출"
//        $0.font = .boldSystemFont(ofSize: 15)
//        $0.textColor = .black
//        $0.textAlignment = .left
//        $0.numberOfLines = 2
//    }
//    
//    let goalOrderPriceTextField = UITextField().then {
//        $0.placeholder = "금액"
//        $0.backgroundColor = .clear
//        $0.textColor = .black
//        $0.keyboardType = .numberPad
//        $0.setPlaceholder(color: .pointRegularLightGray)
//    }
//    
//    private let textfieldBorderView02 = UIView().then {
//        $0.backgroundColor = .pointRegularLightGray
//    }
    
    var completeBtn = UIButton().then {
        $0.isEnabled = false
        $0.backgroundColor = .pointRegularLightGray
        $0.setTitle("완료", for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupView() {
        configView()
        configHierarchy()
        configLayout()
    }
    
    override func configView() {
        completeBtn.layer.cornerRadius = 10
    }
    
    override func configHierarchy() {
        self.addSubviews([
            goalOrderTitleLabel,
            goalOrderCntTitleLabel,
            goalOrderCntTextField,
            textfieldBorderView01,
//            goalOrderPriceTitleLabel,
//            goalOrderPriceTextField,
//            textfieldBorderView02,
            completeBtn
        ])
    }
    
    override func configLayout() {
        goalOrderTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        goalOrderCntTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(goalOrderTitleLabel.snp.bottom).offset(60)
        }
        
        goalOrderCntTextField.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(goalOrderCntTitleLabel.snp.bottom).offset(48)
        }
        
        textfieldBorderView01.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(1)
            $0.top.equalTo(goalOrderCntTextField.snp.bottom)
        }
        
//        goalOrderPriceTitleLabel.snp.makeConstraints {
//            $0.leading.trailing.equalToSuperview().inset(20)
//            $0.top.equalTo(textfieldBorderView01.snp.bottom).offset(48)
//        }
//        
//        goalOrderPriceTextField.snp.makeConstraints {
//            $0.height.equalTo(40)
//            $0.leading.trailing.equalToSuperview().inset(20)
//            $0.top.equalTo(goalOrderPriceTitleLabel.snp.bottom).offset(48)
//        }
//        
//        textfieldBorderView02.snp.makeConstraints {
//            $0.leading.trailing.equalToSuperview().inset(20)
//            $0.height.equalTo(1)
//            $0.top.equalTo(goalOrderPriceTextField.snp.bottom)
//        }
        
        completeBtn.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.keyboardLayoutGuide.snp.top).offset(-20)
            $0.height.equalTo(44)
        }
    }
}
