//
//  AddMealDateView.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/19/24.
//

import UIKit
import SnapKit
import Then

final class AddMealDateView: BaseView {
    
    private let dateView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }
    
    lazy var dateTextField = UITextField().then {
        let dateString = DateFormatterUtility.shared.string(from: Date(), withFormat: "yyyy년 MM월 dd일")
        $0.text = dateString
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
        $0.tintColor = .clear // 커서 색상 투명으로 변경
        $0.backgroundColor = .clear
    }

    
    let dateChevronBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysOriginal).withTintColor(.pointRegularLightGray), for: .normal)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupView() {
        configView()
        configHierarchy()
        configLayout()
    }
    
    override func configView() {
        
    }
    
    override func configHierarchy() {
        self.addSubview(dateView)
        
        dateView.addSubviews([
            dateTextField,
            dateChevronBtn
        ])
    }
    
    override func configLayout() {
        dateView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        dateTextField.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        dateChevronBtn.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(20)
        }
    }

}
