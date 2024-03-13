//
//  OverviewViewController.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/11/24.
//

import UIKit
import SnapKit
import Then
import FSCalendar

final class OverviewViewController: BaseViewController {
    enum SectionLayoutKind: Int, CaseIterable {
        case calendar, saving, orderCnt, menu
        
        var columnInt: Int {
            switch self {
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
    }
    
    
    private lazy var overviewCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            // 섹션 인덱스를 기반으로 SectionLayoutKind를 결정합니다.
            guard let sectionLayoutKind = SectionLayoutKind(rawValue: sectionIndex) else { return nil }

            switch sectionLayoutKind {
            case .calendar: // 첫 번째 섹션
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(360), heightDimension: .absolute(70))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            case .saving: // 두 번째 섹션
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(360), heightDimension: .absolute(300))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            case .orderCnt: // 세 번째 섹션
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(360), heightDimension: .absolute(100))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            case .menu: // 네 번째 섹션, 3개의 셀을 가집니다.
                let largeItemSize = NSCollectionLayoutSize(widthDimension: .absolute(168), heightDimension: .absolute(208))
                let smallItemSize = NSCollectionLayoutSize(widthDimension: .absolute(168), heightDimension: .absolute(100))
                let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)
                let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)

                let leadingGroup = NSCollectionLayoutGroup.vertical(layoutSize: largeItemSize, subitems: [largeItem])
                let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(168), heightDimension: .absolute(200)), subitems: [smallItem, smallItem])
                
                let combinedGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(360), heightDimension: .absolute(200))
                let combinedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: combinedGroupSize, subitems: [leadingGroup, trailingGroup])
                combinedGroup.interItemSpacing = .fixed(10) // 셀 간 간격 설정
                
                let section = NSCollectionLayoutSection(group: combinedGroup)
                section.interGroupSpacing = 10 // 그룹 간 간격 설정
                return section
            }
        }
    }
    
    override func configView() {
        
    }
    
    override func configHierarchy() {
        view.addSubview(overviewCollectionView)
    }

    override func configLayout() {
        overviewCollectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
