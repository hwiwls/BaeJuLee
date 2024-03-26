//
//  OverviewCompositionalLayout.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/14/24.
//

import UIKit

enum OverviewCompositionalLayout: Int, CaseIterable {
    case calendar
    case saving
    case orderCnt
    case menu
    
    static var count: Int {
        return allCases.count
    }
    
    static func create() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { section, environment in
            guard let sectionType = OverviewCompositionalLayout(rawValue: section) else { return nil }

            var sectionLayout: NSCollectionLayoutSection?

            switch sectionType {
            case .calendar:
                sectionLayout = createStyleCalendarSection()
            case .saving:
                sectionLayout = createStyleSavingSection()
            case .orderCnt:
                sectionLayout = createStyleOrderCntSection()
            case .menu:
                sectionLayout = createStyleMenuSection()
            }

//            if section == 0 {
//                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
//                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
//                sectionLayout?.boundarySupplementaryItems.append(header)
//            }

            if section == OverviewCompositionalLayout.count - 1 {
                let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(130))
                let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
                sectionLayout?.boundarySupplementaryItems.append(footer)
            }

            return sectionLayout
        }
    }

    
    static func createStyleCalendarSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    static func createStyleSavingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(240))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(240))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20)
        
        
        return section
    }
    
    static func createStyleOrderCntSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(92))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(92))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 16, trailing: 20)
        
        return section
    }
    
    static func createStyleMenuSection() -> NSCollectionLayoutSection {
        // 첫 번째 셀 - 화면의 절반 너비
        let firstItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(204))
        let firstItem = NSCollectionLayoutItem(layoutSize: firstItemSize)
        
        // 두 번째 셀 - 화면의 절반 너비의 절반
        let secondItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(98))
        let secondItem = NSCollectionLayoutItem(layoutSize: secondItemSize)
        
        // 세 번째 셀 (두 번째 셀과 같은 크기를 가짐)
        let thirdItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(98))
        let thirdItem = NSCollectionLayoutItem(layoutSize: thirdItemSize)
        
        // 두 번째와 세 번째 셀을 위한 수직 그룹 - 화면의 절반 너비의 절반
        let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(204))
        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitems: [secondItem, thirdItem])
        verticalGroup.interItemSpacing = .fixed(8)
        
        // 최종 그룹 생성 (첫 번째 셀 + 수직 그룹)
        // 여기서는 화면 전체 너비를 사용하지만, 각 아이템/그룹은 화면의 절반을 차지
        let finalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(204))
        let finalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: finalGroupSize, subitems: [firstItem, verticalGroup])
        finalGroup.interItemSpacing = .fixed(12)
        
        let section = NSCollectionLayoutSection(group: finalGroup)
 
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 36, trailing: 20)

        return section
 }
    
}
