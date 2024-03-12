//
//  BaseView.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/12/24.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        configView()
        configHierarchy()
        configLayout()
    }
    
    func configView() {
        
    }
    
    func configHierarchy() {
        
    }
    
    func configLayout() {
        
    }
}
