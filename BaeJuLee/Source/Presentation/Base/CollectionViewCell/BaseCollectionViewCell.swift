//
//  BaseCollectionViewCell.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/15/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        configView()
        configHierarchy()
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configView() {
        
    }
    
    func configHierarchy() {
    }
    
    func configLayout() {
    }
}
