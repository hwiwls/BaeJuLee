//
//  IngredientCollectionViewCell.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/22/24.
//

import UIKit

final class IngredientCollectionViewCell: BaseCollectionViewCell {
    
    private let imageBackgroundView = UIView().then {
        $0.backgroundColor = .superLightGray
        $0.layer.cornerRadius = 10
    }
    
    let ingredientImageView = UIImageView().then {
        $0.image = UIImage(named: "PorkBelly")
        $0.contentMode = .scaleAspectFit
    }
    
    let ingredientNameLabel = UILabel().then {
        $0.text = "삼겹살"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15)
    }
    
    let checkBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "checkmark.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.pointRegularLightGray), for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configView() {
        
    }
    
    override func configHierarchy() {
        self.addSubviews([
            imageBackgroundView,
            ingredientNameLabel,
            checkBtn
        ])
        
        imageBackgroundView.addSubview(ingredientImageView)
    }
    
    override func configLayout() {
        imageBackgroundView.snp.makeConstraints {
            $0.size.equalTo(60)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        ingredientImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(44)
        }
        
        ingredientNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(imageBackgroundView.snp.trailing).offset(32)
        }
        
        checkBtn.snp.makeConstraints {
            $0.size.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    func configure(with ingredient: Ingredient, isSelected: Bool) {
        ingredientImageView.image = ingredient.ingredientImage
        ingredientNameLabel.text = ingredient.ingredientName
        
        // Set the check button image based on the selection state
        let checkmarkImage = isSelected ? UIImage(systemName: "checkmark.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.pointGreen) : UIImage(systemName: "checkmark.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.pointRegularLightGray)
        checkBtn.setImage(checkmarkImage, for: .normal)
    }
}
