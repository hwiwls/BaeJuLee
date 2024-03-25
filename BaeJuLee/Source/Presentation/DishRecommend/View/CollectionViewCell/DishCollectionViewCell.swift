//
//  DishCollectionViewCell.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/25/24.
//

import UIKit
import SnapKit
import Then

class DishCollectionViewCell: BaseCollectionViewCell {
    
    let containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
//        $0.layer.shadowColor = UIColor.gray.cgColor
//        $0.layer.shadowOpacity = 0.2
//        $0.layer.shadowRadius = 10
        $0.clipsToBounds = true
    }
    
    let dishImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star")
        $0.backgroundColor = .black
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    let dishNameLabel = UILabel().then {
        $0.text = "dish name"
        $0.font = .boldSystemFont(ofSize: 19)
        $0.textColor = .black
        $0.numberOfLines = 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configHierarchy() {
        self.addSubview(containerView)
        
        containerView.addSubviews([
            dishImageView,
            dishNameLabel
        ])
    }
    
    override func configLayout() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        dishImageView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(dishImageView.snp.width)
        }
        
        dishNameLabel.snp.makeConstraints {
            $0.top.equalTo(dishImageView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
    }
    
    
}
