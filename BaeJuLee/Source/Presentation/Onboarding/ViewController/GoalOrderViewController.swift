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
        print("clicked")
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
