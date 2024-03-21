//
//  OverviewViewController.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/11/24.
//

import UIKit
import SnapKit
import FSCalendar
import RealmSwift

final class OverviewViewController: BaseViewController {
    
    private var viewModel = OverviewViewModel()
    
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "BBBLogo")
        $0.contentMode = .scaleAspectFit
    }
   
    private lazy var overviewCollectionView = UICollectionView(frame: .zero, collectionViewLayout: OverviewCompositionalLayout.create())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    func bindViewModel() {
        viewModel.savings.bind { [weak self] _ in
            DispatchQueue.main.async {
                let indexPath = IndexPath(item: 0, section: OverviewCompositionalLayout.saving.rawValue)
                self?.overviewCollectionView.reloadItems(at: [indexPath])
            }
        }
        
//        viewModel.outputdeliveryProgress.bind { [weak self] _ in
//            DispatchQueue.main.async {
//                let indexPath = IndexPath(item: 1, section: OverviewCompositionalLayout.orderCnt.rawValue)
//                self?.overviewCollectionView.reloadItems(at: [indexPath])
//            }
//        }
//        
        viewModel.outputdeliveryCountText.bind { [weak self] _ in
            DispatchQueue.main.async {
                let indexPath = IndexPath(item: 0, section: OverviewCompositionalLayout.orderCnt.rawValue)
                self?.overviewCollectionView.reloadItems(at: [indexPath])
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func configView() {
        overviewCollectionView.backgroundColor = .pointBackground
        overviewCollectionView.delegate = self
        overviewCollectionView.dataSource = self
        overviewCollectionView.register(SavingCollectionViewCell.self, forCellWithReuseIdentifier: "SavingCollectionViewCell")
        overviewCollectionView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: "CalendarCollectionViewCell")
        overviewCollectionView.register(OrderCntCollectionViewCell.self, forCellWithReuseIdentifier: "OrderCntCollectionViewCell")
        overviewCollectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: "MenuCollectionViewCell")
    }
    
    override func configHierarchy() {
        view.addSubviews([
            logoImageView,
            overviewCollectionView
        ])
    }

    override func configLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.width.equalTo(60)
            $0.height.equalTo(48)
        }
        
        overviewCollectionView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom)
            $0.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension OverviewViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return OverviewCompositionalLayout.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionType = OverviewCompositionalLayout(rawValue: section) else { return 0}
        
        switch sectionType {
        case .calendar:
            return 1
        case .saving:
            return 1
        case .orderCnt:
            return 1
        case .menu:
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let calendarCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCollectionViewCell", for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell() }
        
        guard let savingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SavingCollectionViewCell", for: indexPath) as? SavingCollectionViewCell else { return UICollectionViewCell() }
        
        guard let orderCntCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderCntCollectionViewCell", for: indexPath) as? OrderCntCollectionViewCell else { return UICollectionViewCell() }
        
        guard let menuCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as? MenuCollectionViewCell else { return UICollectionViewCell() }
        
        if let sectionType = OverviewCompositionalLayout(rawValue: indexPath.section) {
            switch sectionType {
            case .calendar:
                calendarCell.calendar.delegate = self
                calendarCell.calendar.dataSource = self
                return calendarCell
            case .saving:
                savingCell.savingLabel.text = viewModel.savings.value
                return savingCell
            case .orderCnt:
                let progress = viewModel.outputdeliveryProgress.value
                let countText = viewModel.outputdeliveryCountText.value
                orderCntCell.configure(withProgress: progress, countText: countText)
                print("here")
                print(progress)
                print(countText)
                        
                return orderCntCell
            case .menu:
                return menuCell
            }
        }
        
        
        return UICollectionViewCell()
    }
    
    
}

extension OverviewViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.remakeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(bounds.height)
        }
        self.view.layoutIfNeeded()
    }
}
