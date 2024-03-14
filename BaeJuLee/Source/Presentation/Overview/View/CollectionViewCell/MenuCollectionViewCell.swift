//
//  MenuCollectionViewCell.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/13/24.
//

import UIKit
import SnapKit
import Then

class MenuCollectionViewCell: BaseCollectionViewCell {
    private var containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "추천받기"
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = .boldSystemFont(ofSize: 16)
        $0.numberOfLines = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configView() {
        
    }
    
    override func configHierarchy() {
        self.addSubview(containerView)
        
        containerView.addSubviews([
            titleLabel
        ])
    }
    
    override func configLayout() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
        }
    }
    
    func setupLayout() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 10
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
}
