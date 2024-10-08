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
    
    weak var delegate: SavingCollectionViewCellDelegate?
    
    private var containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.isUserInteractionEnabled = true
    }
    
    let savingLabel = UILabel().then {
        $0.text = "지난 주 대비\n10원 절약했어요"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 18)
        $0.numberOfLines = 2
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        let attributedString = NSMutableAttributedString(string: $0.text ?? "")
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        $0.attributedText = attributedString
        $0.textAlignment = .center
    }
    
    private let riceImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(named: "rice")
    }
    
    let recordBtn = UIButton().then {
        $0.backgroundColor = .pointGreen
        $0.setTitle("오늘 식사 기록하기", for: .normal)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        setupLayout()
        recordBtn.addTarget(self, action: #selector(recordBtnTapped), for: .touchUpInside)
    }
    
    @objc func recordBtnTapped() {
        print("클릭")
        delegate?.didTapRecordButton()
    }
    
    override func configHierarchy() {
        self.contentView.addSubview(containerView)
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
            $0.top.equalToSuperview().offset(24)
            $0.centerX.equalToSuperview()
        }
        
        riceImageView.snp.makeConstraints {
            $0.size.equalTo(92)
            $0.top.equalTo(savingLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        recordBtn.snp.makeConstraints {
            $0.top.equalTo(riceImageView.snp.bottom).offset(16)
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
