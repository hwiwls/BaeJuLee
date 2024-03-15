//
//  SavingCollectionViewCell.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/13/24.
//

import UIKit
import SnapKit
import Then

final class SavingCollectionViewCell: BaseCollectionViewCell {
    private var containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    
    let savingLabel = UILabel().then {
        $0.text = "지난 주 대비\n10원 절약했어요"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 18)
        $0.numberOfLines = 2
    }
    
    private let riceImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(named: "밥")
    }
    
    let recordBtn = UIButton().then {
        $0.backgroundColor = .pointGreen
        $0.setTitle("오늘 식사 기록하기", for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        setupLayout()
    }
    
    override func configHierarchy() {
        self.addSubview(containerView)
        containerView.addSubviews([
            savingLabel,
            riceImageView,
            recordBtn
        ])
    }
    
    override func configLayout() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        savingLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.centerX.equalToSuperview()
        }
        
        riceImageView.snp.makeConstraints {
            $0.size.equalTo(100)
            $0.top.equalTo(savingLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        recordBtn.snp.makeConstraints {
            $0.top.equalTo(riceImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(35)
            $0.width.equalTo(150)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
}
