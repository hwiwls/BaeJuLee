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
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "BBBLogo")
        $0.contentMode = .scaleAspectFit
    }
   
    private lazy var overviewCollectionView = UICollectionView(frame: .zero, collectionViewLayout: OverviewCompositionalLayout.create())
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.leftBarButtonItem = nil
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        calculateSavings()
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
                return savingCell
            case .orderCnt:
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

// MARK: 날짜 계산을 통한 절약 금액 계산
extension OverviewViewController {
    func calculateWeekRange(from referenceDate: Date) -> (currentWeekStart: Date, lastWeekStart: Date, lastWeekEnd: Date) {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 1 // 주의 첫 번째 날을 일요일로 설정
        
        // 현재 주의 시작일 계산
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: referenceDate)
        guard let currentWeekStart = calendar.date(from: components) else {
            fatalError("Failed to calculate the start of the current week.")
        }
        
        let startOfDay = calendar.startOfDay(for: currentWeekStart)
        
        // 지난 주의 시작일 계산
        guard let lastWeekStart = calendar.date(byAdding: .day, value: -7, to: startOfDay) else {
            fatalError("Failed to calculate the start of the last week.")
        }
        
        // 지난 주의 끝을 계산 (현재 주의 시작 직전 순간)
        guard let lastWeekEnd = calendar.date(byAdding: .second, value: -1, to: startOfDay) else {
            fatalError("Failed to calculate the end of the last week.")
        }
        
        print("startOfday: \(startOfDay), lastWeekStart: \(lastWeekStart), lastWeekEnd: \(lastWeekEnd)")
        
        return (startOfDay, lastWeekStart, lastWeekEnd)
    }
    
    func calculateSavings() {
        let realm = try! Realm()
        let currentDate = Date()
        let (currentWeekStart, lastWeekStart, lastWeekEnd) = calculateWeekRange(from: currentDate)

        guard let user = realm.objects(UserRealmModel.self).first else { return }

        // 이번 주와 지난 주의 배달음식 지출을 계산하는 로직
        let thisWeekDeliverySpend: Double = realm.objects(MealRealmModel.self)
            .filter("mealType == '배달' AND mealRegDate >= %@ AND mealRegDate < %@", currentWeekStart, currentDate)
            .sum(ofProperty: "mealPrice")

        let lastWeekDeliverySpend: Double
        if user.userRegDate >= currentWeekStart {
            lastWeekDeliverySpend = user.onboardingData?.initialDeliveryCostLastWeek ?? 0
        } else {
            lastWeekDeliverySpend = realm.objects(MealRealmModel.self)
                .filter("mealType == '배달' AND mealRegDate >= %@ AND mealRegDate <= %@", lastWeekStart, lastWeekEnd)
                .sum(ofProperty: "mealPrice")
        }

        let savings = max(0, lastWeekDeliverySpend - thisWeekDeliverySpend)
        print("lastWeekDeliverySpend: \(lastWeekDeliverySpend), thisWeekDeliverySpend: \(thisWeekDeliverySpend)")

        print("이번 주에 절약한 금액: \(savings)")
    }
}
