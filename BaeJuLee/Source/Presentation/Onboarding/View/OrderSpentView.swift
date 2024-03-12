//
//  OrderSpentView.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/12/24.
//

import UIKit

final class OrderSpentView: BaseView {
    private let orderCntTitleLabel = UILabel().then {
        $0.text = "저번주 배달 음식\n지출 비용은 총 얼마인가요?"
        $0.font = .boldSystemFont(ofSize: 25)
        $0.textColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    
    private let orderCntsubtitleLabel = UILabel().then {
        $0.text = "입력하신 값은 지출 계산에 도움이 됩니다 :)"
        $0.font = .boldSystemFont(ofSize: 12)
        $0.textColor = .pointRegularLightGray
        $0.textAlignment = .left
    }
    
    let orderCntTextField = UITextField().then {
        $0.placeholder = "금액"
        $0.backgroundColor = .clear
        $0.textColor = .black
        $0.keyboardType = .numberPad
        $0.setPlaceholder(color: .pointRegularLightGray)
    }
    
    private let textfieldBorderView = UIView().then {
        $0.backgroundColor = .pointRegularLightGray
    }
    
    var completeBtn = UIButton().then {
        $0.isEnabled = false
        $0.backgroundColor = .superLightGray
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
            orderCntTitleLabel,
            orderCntsubtitleLabel,
            orderCntTextField,
            textfieldBorderView,
            completeBtn
        ])
    }
    
    override func configLayout() {
        orderCntTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        orderCntsubtitleLabel.snp.makeConstraints {
            $0.top.equalTo(orderCntTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        orderCntTextField.snp.makeConstraints {
            $0.top.equalTo(orderCntsubtitleLabel.snp.bottom).offset(48)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        textfieldBorderView.snp.makeConstraints {
            $0.top.equalTo(orderCntTextField.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        
        completeBtn.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.keyboardLayoutGuide.snp.top).offset(-20)
            $0.height.equalTo(44)
        }
    }
}
