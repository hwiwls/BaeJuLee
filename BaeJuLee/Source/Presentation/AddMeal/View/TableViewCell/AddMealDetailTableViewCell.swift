//
//  AddMealDetailTableViewCell.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/18/24.
//

import UIKit
import SnapKit
import Then
import TextFieldEffects

// TODO: 나중에 테이블뷰 셀로 이용
class AddMealDetailTableViewCell: BaseTableViewCell, UITextFieldDelegate {

    
    private let addMealDetailBackgroundView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let mealTimeLabel = UILabel().then {
        $0.text = "식사 시간(필수)"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
    }
    
    private let mealTypeLabel = UILabel().then {
        $0.text = "식사 유형(필수)"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
    }
    
    private let mealPriceLabel = UILabel().then {
        $0.text = "식사 가격(필수)"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
    }
    
    private let mealNameLabel = UILabel().then {
        $0.text = "식사 이름(선택)"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
    }
    
    let mealPriceTextField = HoshiTextField(frame: .zero).then {
        $0.keyboardType = .numberPad
    }
    
    let mealNameTextField = HoshiTextField(frame: .zero)
    
    let mealTimeStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.spacing = 12
    }
    
    let mealTypeStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.spacing = 12
    }
    
    let breakfastButton = UIButton().then {
        $0.backgroundColor = .pointGreen
        $0.setTitle("아침", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    let lunchButton = UIButton().then {
        $0.backgroundColor = .superLightGray
        $0.setTitle("점심", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
    }
    
    let dinnerButton = UIButton().then {
        $0.backgroundColor = .superLightGray
        $0.setTitle("저녁", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
    }
    
    let snackButton = UIButton().then {
        $0.backgroundColor = .superLightGray
        $0.setTitle("간식", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
    }
    
    let homeCookedButton = UIButton().then {
        $0.backgroundColor = .pointGreen
        $0.setTitle("집밥", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.isEnabled = true
    }
    
    let deliveryButton = UIButton().then {
        $0.backgroundColor = .superLightGray
        $0.setTitle("배달", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
    }
    
    let diningOutButton = UIButton().then {
        $0.backgroundColor = .superLightGray
        $0.setTitle("외식", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func configView() {
        backgroundColor = .clear
        
        mealNameTextField.borderActiveColor = .pointGreen
        mealNameTextField.borderInactiveColor = .pointRegularLightGray
        mealNameTextField.placeholder = "ex. 김치찌개"
        mealNameTextField.placeholderColor = .pointRegularLightGray
        mealNameTextField.textColor = .black
        
        mealPriceTextField.borderActiveColor = .pointGreen
        mealPriceTextField.borderInactiveColor = .pointRegularLightGray
        mealPriceTextField.placeholder = "ex. 10,000원"
        mealPriceTextField.placeholderColor = .pointRegularLightGray
        mealPriceTextField.textColor = .black
        
        addMealDetailBackgroundView.layer.cornerRadius = 10
        addMealDetailBackgroundView.layer.masksToBounds = false
        addMealDetailBackgroundView.layer.shadowColor = UIColor.black.cgColor
        addMealDetailBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 4)
        addMealDetailBackgroundView.layer.shadowOpacity = 0.1
        addMealDetailBackgroundView.layer.shadowRadius = 4

        configureButtonStyle(breakfastButton)
        configureButtonStyle(lunchButton)
        configureButtonStyle(dinnerButton)
        configureButtonStyle(snackButton)
        configureButtonStyle(homeCookedButton)
        configureButtonStyle(deliveryButton)
        configureButtonStyle(diningOutButton)
        
        setupToolbar()
        
        breakfastButton.addTarget(self, action: #selector(mealTimeButtonPressed), for: .touchUpInside)
        lunchButton.addTarget(self, action: #selector(mealTimeButtonPressed), for: .touchUpInside)
        dinnerButton.addTarget(self, action: #selector(mealTimeButtonPressed), for: .touchUpInside)
        snackButton.addTarget(self, action: #selector(mealTimeButtonPressed), for: .touchUpInside)

        homeCookedButton.addTarget(self, action: #selector(mealTypeButtonPressed), for: .touchUpInside)
        deliveryButton.addTarget(self, action: #selector(mealTypeButtonPressed), for: .touchUpInside)
        diningOutButton.addTarget(self, action: #selector(mealTypeButtonPressed), for: .touchUpInside)
        
        mealPriceTextField.delegate = self
//        mealPriceTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            
    }

//    @objc func textFieldDidChange(_ textField: UITextField) {
//        delegate?.mealPriceDidChange(textField.text)
//    }

    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func setupToolbar() {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 44)))
        toolbar.sizeToFit()

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(dismissKeyboard))
        
        toolbar.setItems([flexibleSpace, doneButton], animated: false)

        mealPriceTextField.inputAccessoryView = toolbar
        mealNameTextField.inputAccessoryView = toolbar
    }
    
    @objc private func dismissKeyboard() {
        mealPriceTextField.resignFirstResponder()
        mealNameTextField.resignFirstResponder()
    }
    
    @objc func mealTimeButtonPressed(_ sender: UIButton) {
        guard AddMealViewController.MealTime(rawValue: sender.titleLabel?.text ?? "") != nil else { return }
//        delegate?.mealTimeButtonPressed(mealTime)
    }

    @objc func mealTypeButtonPressed(_ sender: UIButton) {
        guard AddMealViewController.MealType(rawValue: sender.titleLabel?.text ?? "") != nil else { return }
        //delegate?.mealTypeButtonPressed(mealType)
    }
    
    private func configureButtonStyle(_ button: UIButton) {
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    func updateButtonStyles(selectedMealTime: AddMealViewController.MealTime?, selectedMealType: AddMealViewController.MealType?) {
        let mealTimeButtons = [breakfastButton, lunchButton, dinnerButton, snackButton]
            mealTimeButtons.forEach { button in
                button.backgroundColor = .superLightGray
                button.setTitleColor(.gray, for: .normal)
            }
        
        if let selectedMealTime = selectedMealTime {
            let selectedButton = mealTimeButtons.first(where: { $0.titleLabel?.text == selectedMealTime.rawValue })
            selectedButton?.backgroundColor = .pointGreen
            selectedButton?.setTitleColor(.white, for: .normal)
        }
        
        // 식사 유형 버튼 스타일 업데이트
        let mealTypeButtons = [homeCookedButton, deliveryButton, diningOutButton]
        mealTypeButtons.forEach { button in
            button.backgroundColor = .superLightGray
            button.setTitleColor(.gray, for: .normal)
        }
        
        if let selectedMealType = selectedMealType {
            let selectedButton = mealTypeButtons.first(where: { $0.titleLabel?.text == selectedMealType.rawValue })
            selectedButton?.backgroundColor = .pointGreen
            selectedButton?.setTitleColor(.white, for: .normal)
        }
    }
    
    override func configHierarchy() {
        self.addSubviews([
            addMealDetailBackgroundView
        ])
        
        addMealDetailBackgroundView.addSubviews([
            mealTimeLabel,
            mealTypeLabel,
            mealPriceLabel,
            mealNameLabel,
            mealTimeStackView,
            mealTypeStackView,
            mealPriceTextField,
            mealNameTextField
        ])
        
        mealTimeStackView.addArrangedSubviews([
            breakfastButton,
            lunchButton,
            dinnerButton,
            snackButton
        ])
        
        mealTypeStackView.addArrangedSubviews([
            homeCookedButton,
            deliveryButton,
            diningOutButton
        ])
    }
    
    override func configLayout() {
        addMealDetailBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        breakfastButton.snp.makeConstraints {
            $0.height.equalTo(35)
        }
        
        lunchButton.snp.makeConstraints {
            $0.height.equalTo(35)
        }
        
        dinnerButton.snp.makeConstraints {
            $0.height.equalTo(35)
        }
        
        snackButton.snp.makeConstraints {
            $0.height.equalTo(35)
        }
        
        mealTimeLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(20)
        }
        
        mealTimeStackView.snp.makeConstraints {
            $0.top.equalTo(mealTimeLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        mealTypeLabel.snp.makeConstraints {
            $0.top.equalTo(mealTimeStackView.snp.bottom).offset(36)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        mealTypeStackView.snp.makeConstraints {
            $0.top.equalTo(mealTypeLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        homeCookedButton.snp.makeConstraints {
            $0.height.equalTo(35)
        }
        
        deliveryButton.snp.makeConstraints {
            $0.height.equalTo(35)
        }
        
        diningOutButton.snp.makeConstraints {
            $0.height.equalTo(35)
        }
        
        mealPriceLabel.snp.makeConstraints {
            $0.top.equalTo(mealTypeStackView.snp.bottom).offset(36)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        mealPriceTextField.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.top.equalTo(mealPriceLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        mealNameLabel.snp.makeConstraints {
            $0.top.equalTo(mealPriceTextField.snp.bottom).offset(36)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        mealNameTextField.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.top.equalTo(mealNameLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }


}
