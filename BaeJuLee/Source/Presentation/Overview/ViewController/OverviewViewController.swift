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
    
    

    
    func koreanWeekRange(from referenceDate: Date) -> (currentWeekStart: Date, lastWeekStart: Date, lastWeekEnd: Date) {
        // calendar 설정
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")! // Calendar 시간대를 한국 시간대로 설정
        calendar.locale = Locale(identifier: "ko_KR")   // 로케일 설정: 날짜와 시간 포맷팅을 한국에 맞춰서
        calendar.firstWeekday = 1 // 일요일을 주의 첫 번째 날로 설정

        // 현재 주의 시작일 계산
        // referenceDate로부터 현재 주의 시작일(일요일)을 찾음. 참고로 referenceDate는 Date()
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: referenceDate)    // referenceDate로부터 날짜 구성 요소 추출
        guard let currentWeekStart = calendar.date(from: components) else { // 현재 주의 시작일 계산
            fatalError("이번주 시작 계산 실패")
        }

        // 일요일 0시 기준으로 설정
        let startOfDay = calendar.startOfDay(for: currentWeekStart) // GMT 기준 주의 시작 날짜
        let koreanOffset = calendar.timeZone.secondsFromGMT(for: startOfDay)    // GMT와 한국 시간대 간의 시차 계산
        let correctedStartOfDay = startOfDay.addingTimeInterval(Double(koreanOffset))   // GMT로 계산된 자정 시간에 한국 시간대의 시차 더하기
        
        print("startOfDay: \(startOfDay)")
        print("koreanOffset: \(koreanOffset)")
        print("correctedStartOfDay: \(correctedStartOfDay)")

        // 지난 주의 시작과 끝을 계산
        // 계산된 현재 주의 시작일로부터 7을 빼면 지난 주의 시작일이 구해짐
        guard let lastWeekStart = calendar.date(byAdding: .day, value: -7, to: correctedStartOfDay) else {
                fatalError("지난주 시작 계산 실패")
            }

            // 지난 주의 끝을 계산 (현재 주의 시작 직전 순간)
            let lastWeekEnd = correctedStartOfDay.addingTimeInterval(-1)
        


        return (correctedStartOfDay, lastWeekStart, lastWeekEnd)
    }
    
    func calculateSavings() {
        let realm = try! Realm()
        let currentDate = Date()
        let (currentWeekStart, lastWeekStart, lastWeekEnd) = koreanWeekRange(from: currentDate)

        guard let user = realm.objects(UserRealmModel.self).first else { return }

        let thisWeekDeliverySpend: Double = realm.objects(MealRealmModel.self)
            .filter("mealType == %@ AND mealRegDate >= %@ AND mealRegDate < %@", "배달", currentWeekStart, currentDate)
            .sum(ofProperty: "mealPrice")

        let lastWeekDeliverySpend: Double
        
        print("here!!!")
        print("user.userRegDate: \(user.userRegDate)")
        print("lastWeekStart: \(lastWeekStart)")
        print("currentWeekStart: \(currentWeekStart)")
        print("here!!!")
            
        if user.userRegDate >= currentWeekStart {
            // 새로운 사용자의 경우, 온보딩 정보 사용
            lastWeekDeliverySpend = user.onboardingData?.initialDeliveryCostLastWeek ?? 0
        } else {
            print("lastWeekEnd: \(lastWeekEnd)")
            lastWeekDeliverySpend = realm.objects(MealRealmModel.self)
                .filter("mealType == %@ AND mealRegDate >= %@ AND mealRegDate < %@", "배달", lastWeekStart, lastWeekEnd)
                .sum(ofProperty: "mealPrice")
            print("here!!!")
        }

        let savings = max(0, lastWeekDeliverySpend - thisWeekDeliverySpend)

        print("lastWeekDeliverySpend: \(lastWeekDeliverySpend)")
        print("thisWeekDeliverySpend: \(thisWeekDeliverySpend)")
    
        let thisWeekDeliveryCount: Int = realm.objects(MealRealmModel.self)
            .filter("mealType == %@ AND mealRegDate >= %@ AND mealRegDate < %@", "배달", currentWeekStart, currentDate)
            .count

        // 목표 대비 절약 횟수 비교
        let targetDeliveryCount = user.onboardingData?.targetDeliveryCount ?? 0
//            let deliveryCountComparison = targetDeliveryCount - thisWeekDeliveryCount

        print("이번 주에 절약한 금액: \(savings)")
        print("이번 주 배달 횟수: \(thisWeekDeliveryCount)")
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
