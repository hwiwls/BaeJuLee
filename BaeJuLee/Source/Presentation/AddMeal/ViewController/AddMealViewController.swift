//
//  AddMealViewController.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/11/24.
//

import UIKit
import SnapKit
import Then
import RealmSwift
import Toast

final class AddMealViewController: BaseViewController, UITextFieldDelegate {
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
    
    private let addMealDetailView = AddMealDetailView()

    
    let dateView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }
    
    let dateLabel = UILabel().then {
        let dateString = DateFormatterUtility.shared.string(from: Date(), withFormat: "yyyy년 MM월 dd일")
        $0.text = dateString
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
    }
    
    let datePicker = UIDatePicker().then {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .wheels
        $0.locale = Locale(identifier: "ko-KR")
    }
    
    let dateChevronBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysOriginal).withTintColor(.pointRegularLightGray), for: .normal)
    }
    
    let mealTimeLabel = UILabel().then {
        $0.text = "식사 시간(필수)"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
        $0.textAlignment = .left
    }
    
    let mealView = UIView().then {
        $0.backgroundColor = .white
    }

    let completeButton = UIButton().then {
        $0.backgroundColor = .superLightGray
        $0.setTitle("저장", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.isEnabled = false
        $0.layer.cornerRadius = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configureTapGesture()
        setupInitialSelection()
        addKeyboardObservers()
            setupTapGesture()
            setupToolbar()
    }
    
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        if self.view.frame.origin.y == 0 {
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
        let toolbar = UIToolbar(frame: .zero)
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(dismissKeyboard))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        
        addMealDetailView.mealPriceTextField.inputAccessoryView = toolbar
        addMealDetailView.mealNameTextField.inputAccessoryView = toolbar
    }
    
    private func setupInitialSelection() {
        viewModel.inputMealTimeSelected.value = .breakfast
        viewModel.inputMealTypeSelected.value = .homeCooked
        viewModel.inputMealPriceEntered.value = false
            
        
        addMealDetailView.updateButtonStyles(selectedMealTime: viewModel.inputMealTimeSelected.value, selectedMealType: viewModel.inputMealTypeSelected.value)
        
    }
    
    
    private func bindViewModel() {
        viewModel.outputFormattedDate.bind { [weak self] formattedDate in
            guard let formattedDate = formattedDate else { return }
            self?.dateLabel.text = formattedDate
        }
        
        viewModel.outputIsCompleteButtonEnabled.bind { [weak self] isEnabled in
            self?.completeButton.isEnabled = isEnabled
            self?.completeButton.backgroundColor = isEnabled ? .pointGreen : .superLightGray
            self?.completeButton.setTitleColor(isEnabled ? .white : .gray, for: .normal)
        }
        
        addMealDetailView.breakfastButton.addTarget(self, action: #selector(mealTimeButtonPressed), for: .touchUpInside)
        addMealDetailView.lunchButton.addTarget(self, action: #selector(mealTimeButtonPressed), for: .touchUpInside)
        addMealDetailView.dinnerButton.addTarget(self, action: #selector(mealTimeButtonPressed), for: .touchUpInside)
        addMealDetailView.snackButton.addTarget(self, action: #selector(mealTimeButtonPressed), for: .touchUpInside)

        addMealDetailView.homeCookedButton.addTarget(self, action: #selector(mealTypeButtonPressed), for: .touchUpInside)
        addMealDetailView.deliveryButton.addTarget(self, action: #selector(mealTypeButtonPressed), for: .touchUpInside)
        addMealDetailView.diningOutButton.addTarget(self, action: #selector(mealTypeButtonPressed), for: .touchUpInside)
        
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

    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showDatePicker))
        dateView.isUserInteractionEnabled = true
        dateView.addGestureRecognizer(tapGesture)
    }
    
    @objc func showDatePicker() {
        datePicker.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 216)
        datePicker.backgroundColor = .white
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(datePicker)
        let okAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
                self?.viewModel.inputDateSelected.value = self?.datePicker.date
            }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

    override func configView() {
        addMealDetailView.mealPriceTextField.delegate = self
        
        addMealDetailView.mealPriceTextField.addTarget(self, action: #selector(textFieldDidChangeSelection), for: .editingChanged)
        
        completeButton.addTarget(self, action: #selector(saveMealData), for: .touchUpInside)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {
            viewModel.inputMealPriceEntered.value = false
            return
        }
        viewModel.inputMealPriceEntered.value = !text.isEmpty
    }
    
    @objc private func saveMealData() {
        guard let mealTime = viewModel.inputMealTimeSelected.value?.rawValue,
              let mealType = viewModel.inputMealTypeSelected.value?.rawValue else {
            return
        }
        
        // Realm 데이터 저장
        let meal = MealRealmModel(mealRegDate: Date(), mealTime: mealTime, mealType: mealType, mealPrice: Double(addMealDetailView.mealPriceTextField.text ?? "0") ?? 0.0, mealName: addMealDetailView.mealNameTextField.text ?? "")
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(meal)
            
            
        }
        
        self.view.makeToast("저장 성공", duration: 3.0, position: .bottom)
                
        self.navigationController?.popViewController(animated: true)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func configHierarchy() {
        view.addSubviews([
            dateView,
            addMealDetailView,
            completeButton
        ])
        
        dateView.addSubviews([
            dateLabel,
            dateChevronBtn
        ])
    }
    
    override func configLayout() {
        dateView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(36)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(60)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(200)
        }
        
        dateChevronBtn.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(20)
        }
        
        addMealDetailView.snp.makeConstraints {
            $0.height.equalTo(450)
            $0.top.equalTo(dateView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        completeButton.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(44)
        }
        
        
    }

}
