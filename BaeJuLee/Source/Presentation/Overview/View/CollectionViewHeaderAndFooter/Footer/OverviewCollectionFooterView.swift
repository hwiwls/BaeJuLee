//
//  OverviewCollectionFooterView.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/26/24.
//

import UIKit

class OverviewCollectionFooterView: UICollectionReusableView {
    static let identifier = "OverviewCollectionFooterView"
    weak var delegate: OverviewCollectionFooterViewDelegate?
    
    private let privacyPolicyBtn = UIButton().then {
        $0.setTitle("개인정보처리방침", for: .normal)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 13)
    }
    
    private let copyrightLabel = UILabel().then {
        $0.text = "ⓒ 2024 HWIJIN JEONG"
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .darkGray
    }
    
    private let iconCopyrightLabel = UILabel().then {
        $0.text = "Icons by Icons8\nIcons made by www.flaticon.com"
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .darkGray
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        privacyPolicyBtn.addTarget(self, action: #selector(privacyPolicyBtnDidTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func privacyPolicyBtnDidTap() {
        delegate?.privacyPolicyButtonDidTap()
    }
    
    func configure() {
        backgroundColor = .clear
        addSubviews([
            privacyPolicyBtn,
            copyrightLabel,
            iconCopyrightLabel
        ])
        
        privacyPolicyBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-90)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        copyrightLabel.snp.makeConstraints {
            $0.top.equalTo(privacyPolicyBtn.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
        }
        
        iconCopyrightLabel.snp.makeConstraints {
            $0.top.equalTo(copyrightLabel.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
        }
    }
}
