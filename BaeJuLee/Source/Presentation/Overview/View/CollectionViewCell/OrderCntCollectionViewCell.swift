//
//  OrderCntCollectionViewCell.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/13/24.
//

import UIKit
import SnapKit
import Then

final class OrderCntCollectionViewCell: BaseCollectionViewCell {
    private var containerView = UIView().then {
        $0.backgroundColor = .white 
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    
    private let imageContainerView = UIView().then {
        $0.backgroundColor = .superLightGray
        $0.layer.cornerRadius = 26
        $0.layer.masksToBounds = true
    }
    
    private let deliveryImageView = UIImageView().then {
        $0.image = UIImage(named: "오토바이")
    }
    
    private let orderCntLabel = UILabel().then {
        $0.text = "이번주 배달 횟수"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 15)
    }
    
    lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = .superLightGray
        view.progressTintColor = .pointPink
        view.progress = 0.1
        return view
    }()
    
    var cntLabel = UILabel().then {
        $0.text = "2/10 회"
        $0.textColor = .lightGray
        $0.font = .boldSystemFont(ofSize: 12)
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
            imageContainerView,
            deliveryImageView,
            orderCntLabel,
            progressView,
            cntLabel
        ])
    }
    
    override func configLayout() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageContainerView.snp.makeConstraints {
            $0.size.equalTo(52)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        deliveryImageView.snp.makeConstraints {
            $0.size.equalTo(36)
            $0.center.equalTo(imageContainerView)
        }
        
        orderCntLabel.snp.makeConstraints {
            $0.top.equalTo(imageContainerView.snp.top)
            $0.leading.equalTo(imageContainerView.snp.trailing).offset(16)
        }
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(orderCntLabel.snp.bottom).offset(20)
            $0.leading.equalTo(imageContainerView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        cntLabel.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(8)
            $0.trailing.equalTo(progressView.snp.trailing)
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
