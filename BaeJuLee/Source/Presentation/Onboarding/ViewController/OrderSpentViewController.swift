//
//  OrderSpentViewController.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/12/24.
//

import UIKit
import SnapKit
import Then

final class OrderSpentViewController: BaseViewController {
    private var viewModel = OrderSpentViewModel()
    
    private let orderSpentView = OrderSpentView()
    
    var orderCount: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupGestureToHideKeyboard()
    }
    
    private func bindViewModel() {
        orderSpentView.orderSpentTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        viewModel.isCompleteButtonEnabled.bind { [weak self] isEnabled in
            self?.orderSpentView.completeBtn.isEnabled = isEnabled
            self?.orderSpentView.completeBtn.backgroundColor = isEnabled ? .pointGreen : .lightGray
        }
    }
    
    override func configView() {
        orderSpentView.completeBtn.addTarget(self, action: #selector(completeBtnClicked), for: .touchUpInside)
    }
    
    @objc func completeBtnClicked() {
        print("clicked")
        let vc = GoalOrderViewController()
        vc.orderCount = self.orderCount 
        vc.orderSpent = orderSpentView.orderSpentTextField.text
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func configHierarchy() {
        view.addSubview(orderSpentView)
        
    }
    
    override func configLayout() {
        orderSpentView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension OrderSpentViewController {
    @objc private func textFieldDidChange(_ textField: UITextField) {
        viewModel.orderSpentText.value = textField.text
    }

    private func setupGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
