//
//  GoalOrderCntView.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/12/24.
//

import UIKit
import SnapKit
import Then
import TextFieldEffects

final class GoalOrderView: BaseView {
    
    private let goalOrderTitleLabel = UILabel().then {
        $0.text = "앞으로의 목표를 알려주세요!"
        $0.font = .boldSystemFont(ofSize: 25)
        $0.textColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    
    let goalOrderCntTextField = HoshiTextField(frame: .zero).then {
        $0.keyboardType = .numberPad
        $0.borderActiveColor = .pointGreen
        $0.borderInactiveColor = .pointRegularLightGray
        $0.placeholder = "횟수"
        $0.placeholderColor = .pointRegularLightGray
        $0.textColor = .black
    }
    
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
            goalOrderCntTextField,
            completeBtn
        ])
    }
    
    override func configLayout() {
        goalOrderTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        goalOrderCntTextField.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(goalOrderTitleLabel.snp.bottom).offset(48)
        }
        
        completeBtn.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.keyboardLayoutGuide.snp.top).offset(-20)
            $0.height.equalTo(44)
        }
    }
}
