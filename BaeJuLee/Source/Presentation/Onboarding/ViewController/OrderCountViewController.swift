//
//  OnboardingViewController.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/12/24.
//

import UIKit
import SnapKit
import Then

final class OrderCountViewController: BaseViewController {
    private var viewModel = OrderCountViewModel()
    
    private let orderCountView = OrderCountView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupGestureToHideKeyboard()
    }
    
    override func configView() {
    }
    
    override func configHierarchy() {
        view.addSubview(orderCountView)
        
    }
    
    override func configLayout() {
        orderCountView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension OrderCountViewController {
    private func bindViewModel() {
        orderCountView.orderCntTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        viewModel.isCompleteButtonEnabled.bind { [weak self] isEnabled in
            self?.orderCountView.completeBtn.isEnabled = isEnabled
            self?.orderCountView.completeBtn.backgroundColor = isEnabled ? .pointGreen : .lightGray
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        viewModel.orderCountText.value = textField.text
    }

    private func setupGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
   
}

