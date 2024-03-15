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
    var viewModel = AddMealViewModel()
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        configureTapGesture()
    }
    
    private func bindViewModel() {
        viewModel.outputFormattedDate.bind { [weak self] formattedDate in
                guard let formattedDate = formattedDate else { return }
                self?.dateLabel.text = formattedDate
            }
    }

    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showDatePicker))
        dateView.isUserInteractionEnabled = true
        dateView.addGestureRecognizer(tapGesture)
    }
    
    override func configView() {
    }
    
    @objc func showDatePicker() {
        datePicker.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 216)
        datePicker.backgroundColor = .white
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(datePicker)
        let okAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
                self?.viewModel.inputDateSelected.value = self?.datePicker.date
            }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

    
    
    override func configHierarchy() {
        view.addSubviews([
            dateView
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
        
        
    }

}
