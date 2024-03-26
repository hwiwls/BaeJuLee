//
//  OverviewCollectionFooterView.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/26/24.
//

import UIKit

class OverviewCollectionFooterView: UICollectionReusableView {
    static let identifier = "OverviewCollectionFooterView"
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Footer".uppercased()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    
    func configure() {
        backgroundColor = .systemGreen
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}
