//
//  AddMealViewController.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/11/24.
//

import UIKit
import SnapKit
import Then

final class AddMealViewController: BaseViewController {
    enum MealTime: String {
        case breakfast = "아침"
        case lunch = "점심"
        case dinner = "저녁"
        case snack = "간식"
    }

    enum MealType: String {
        case homeCooked = "집밥"
        case delivery = "배달"
        case diningOut = "외식"
    }
    
    var viewModel = AddMealViewModel()
    
    private let addMealDateView = AddMealDateView()
    
    private let addMealDetailView = AddMealDetailView()
    
    // 편집 중인 텍스트 필드: dateTextField 입력시 완료 버튼 활성화를 피하려고
    private var activeTextField: UITextField?
    
    let datePicker = UIDatePicker().then {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .wheels
        $0.locale = Locale(identifier: "ko-KR")
    }

    let completeButton = UIButton().then {
        $0.backgroundColor = .superLightGray
        $0.setTitle("저장", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.isEnabled = false
        $0.layer.cornerRadius = 10
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupInitialSelection()
        addKeyboardObservers()
        setupTapGesture()
        setupToolbar()
        setupDatePickerAndToolbar()
    }
    
    
    
    private func setupInitialSelection() {
        viewModel.inputMealTimeSelected.value = .breakfast
        viewModel.inputMealTypeSelected.value = .homeCooked
        viewModel.inputMealPriceEntered.value = false
            
        
        addMealDetailView.updateButtonStyles(selectedMealTime: viewModel.inputMealTimeSelected.value, selectedMealType: viewModel.inputMealTypeSelected.value)
        
    }
    
    
    private func bindViewModel() {
        viewModel.outputFormattedDate.bind { [weak self] formattedDate in
            guard let self = self, let formattedDate = formattedDate else { return }
            self.addMealDateView.dateTextField.text = formattedDate
        }
        
        viewModel.outputIsCompleteButtonEnabled.bind { [weak self] isEnabled in
            self?.completeButton.isEnabled = isEnabled
            self?.completeButton.backgroundColor = isEnabled ? .pointGreen : .superLightGray
            self?.completeButton.setTitleColor(isEnabled ? .white : .gray, for: .normal)
        }
    }
    

   
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == addMealDetailView.mealPriceTextField {
            guard let text = textField.text else {
                viewModel.inputMealPriceEntered.value = false
                return
            }
            viewModel.inputMealPriceEntered.value = !text.isEmpty
        }
    }
    
   
    override func configView() {
        addMealDateView.dateTextField.delegate = self
        
        addMealDetailView.mealPriceTextField.delegate = self
        addMealDetailView.mealNameTextField.delegate = self
        
        addMealDetailView.mealPriceTextField.addTarget(self, action: #selector(textFieldDidChangeSelection), for: .editingChanged)
        
        completeButton.addTarget(self, action: #selector(saveMealData), for: .touchUpInside)
        
        addMealDetailView.breakfastButton.addTarget(self, action: #selector(mealTimeButtonPressed), for: .touchUpInside)
        addMealDetailView.lunchButton.addTarget(self, action: #selector(mealTimeButtonPressed), for: .touchUpInside)
        addMealDetailView.dinnerButton.addTarget(self, action: #selector(mealTimeButtonPressed), for: .touchUpInside)
        addMealDetailView.snackButton.addTarget(self, action: #selector(mealTimeButtonPressed), for: .touchUpInside)

        addMealDetailView.homeCookedButton.addTarget(self, action: #selector(mealTypeButtonPressed), for: .touchUpInside)
        addMealDetailView.deliveryButton.addTarget(self, action: #selector(mealTypeButtonPressed), for: .touchUpInside)
        addMealDetailView.diningOutButton.addTarget(self, action: #selector(mealTypeButtonPressed), for: .touchUpInside)
    }

    
    @objc private func saveMealData() {
        viewModel.saveMealData(mealName: addMealDetailView.mealNameTextField.text, mealPrice: addMealDetailView.mealPriceTextField.text)
//        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func configHierarchy() {
        view.addSubviews([
            addMealDateView,
            addMealDetailView,
            completeButton
        ])
    }
    
    override func configLayout() {
        addMealDateView.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(36)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        addMealDetailView.snp.makeConstraints {
            $0.height.equalTo(450)
            $0.top.equalTo(addMealDateView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        completeButton.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(52)
        }
        
        
    }

}

extension AddMealViewController {
    func setupDatePickerAndToolbar() {
        // DatePicker 설정
        datePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)

        // Toolbar 설정
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(donePressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: true)

        // dateTextField 입력 방식 변경
        addMealDateView.dateTextField.inputAccessoryView = toolbar
        addMealDateView.dateTextField.inputView = datePicker
    }

    @objc func datePickerChanged() {
        let selectedDate = datePicker.date
        let timeZoneOffset = TimeZone.current.secondsFromGMT(for: selectedDate)
        let localDate = Calendar.current.date(byAdding: .second, value: timeZoneOffset, to: selectedDate)!

        viewModel.inputMealDateSelected.value = datePicker.date
        viewModel.updateFormattedDate(date: localDate)
    }
    
//    func updateDateTextFieldWithLocalDate(localDate: Date) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
//        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
//        addMealDateView.dateTextField.text = dateFormatter.string(from: localDate)
//    }

    @objc func donePressed() {
        datePickerChanged()
        view.endEditing(true)
    }
    
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if let activeTextField = activeTextField, (activeTextField == addMealDetailView.mealPriceTextField || activeTextField == addMealDetailView.mealNameTextField), self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardSize.height / 2
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupToolbar() {
        let toolbar = UIToolbar(
            frame: CGRect(
                origin: .zero,
                size: CGSize(width: 100, height: 44)
            )
        )
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(dismissKeyboard))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        
        addMealDetailView.mealPriceTextField.inputAccessoryView = toolbar
        addMealDetailView.mealNameTextField.inputAccessoryView = toolbar
    }
    
    @objc private func mealTimeButtonPressed(_ sender: UIButton) {
        switch sender {
        case addMealDetailView.breakfastButton:
            viewModel.inputMealTimeSelected.value = .breakfast
        case addMealDetailView.lunchButton:
            viewModel.inputMealTimeSelected.value = .lunch
        case addMealDetailView.dinnerButton:
            viewModel.inputMealTimeSelected.value = .dinner
        case addMealDetailView.snackButton:
            viewModel.inputMealTimeSelected.value = .snack
        default:
            break
        }
        
        addMealDetailView.updateButtonStyles(selectedMealTime: viewModel.inputMealTimeSelected.value, selectedMealType: viewModel.inputMealTypeSelected.value)
    }
    
    @objc private func mealTypeButtonPressed(_ sender: UIButton) {
        switch sender {
        case addMealDetailView.homeCookedButton:
            viewModel.inputMealTypeSelected.value = .homeCooked
        case addMealDetailView.deliveryButton:
            viewModel.inputMealTypeSelected.value = .delivery
        case addMealDetailView.diningOutButton:
            viewModel.inputMealTypeSelected.value = .diningOut
        default:
            break
        }
        
        addMealDetailView.updateButtonStyles(selectedMealTime: viewModel.inputMealTimeSelected.value, selectedMealType: viewModel.inputMealTypeSelected.value)
    }
    
    
    @objc func showDatePicker() {
        
    }
    
    @objc func tapCancel() {
            self.resignFirstResponder()
        }
}

extension AddMealViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == addMealDateView.dateTextField {
            return false
        } else {
            return true
        }
  }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        if textField == addMealDateView.dateTextField {
            return
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
}
