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
    
    let titleLabel = UILabel().then {
        let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
        let attributedString = NSMutableAttributedString(
            string: "AI에게 음식\n추천받기",
            attributes: [
                .paragraphStyle: paragraphStyle,
                .font: UIFont.boldSystemFont(ofSize: 16),
                .foregroundColor: UIColor.black
            ]
        )

        $0.attributedText = attributedString
        $0.numberOfLines = 0
    }
    
    let menuImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star")
        $0.contentMode = .scaleAspectFit
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
            titleLabel,
            menuImageView
        ])
    }
    
    override func configLayout() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
        }
        
        menuImageView.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(12)
            $0.size.equalTo(48)
        }
    }
    
    func setupLayout() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
}
