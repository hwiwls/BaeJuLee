//
//  GoalOrderCntViewController.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/12/24.
//

import UIKit

final class GoalOrderViewController: BaseViewController {
    private var viewModel = GoalOrderViewModel()
    
    private let goalOrderView = GoalOrderView()
    
    var orderCount: String?
    var orderSpent: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupGestureToHideKeyboard()
    }
    
    private func bindViewModel() {
        goalOrderView.goalOrderCntTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        viewModel.isCompleteButtonEnabled.bind { [weak self] isEnabled in
            self?.goalOrderView.completeBtn.isEnabled = isEnabled
            self?.goalOrderView.completeBtn.backgroundColor = isEnabled ? .pointGreen : .lightGray
        }
    }
    
    override func configView() {
        goalOrderView.completeBtn.addTarget(self, action: #selector(completeBtnClicked), for: .touchUpInside)
    }
    
    @objc func completeBtnClicked() {
        let repository = UserRepository()
        
        let onboardingData = OnboardingDataModel()
        onboardingData.initialDeliveryCountLastWeek = Int(orderCount ?? "0") ?? 0
        onboardingData.initialDeliveryCostLastWeek = Double(orderSpent ?? "0.0") ?? 0

        let targetDeliveryCount = Int(viewModel.goalOrderCntText.value ?? "0") ?? 0
        
        repository.createUser(onboardingData: onboardingData, goalOrderCnt: targetDeliveryCount)
        repository.updateUserOnboardingCompletion()
        
        let vc = CustomTabBarController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func configHierarchy() {
        view.addSubview(goalOrderView)
    }
    
    override func configLayout() {
        goalOrderView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension GoalOrderViewController {
    @objc private func textFieldDidChange(_ textField: UITextField) {
        viewModel.goalOrderCntText.value = textField.text
    }

    private func setupGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
