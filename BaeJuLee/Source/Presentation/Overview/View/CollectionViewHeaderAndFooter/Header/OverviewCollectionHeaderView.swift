//
//  OverviewCollectionFooterView.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/26/24.
//

import UIKit

class OverviewCollectionHeaderView: UICollectionReusableView {
    static let identifier = "OverviewCollectionHeaderView"
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Header".uppercased()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    
    func configure() {
        backgroundColor = .clear
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}
