//
//  DishRecommendView.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/25/24.
//

import UIKit

class DishRecommendView: BaseView {
    
    private let titleLabel = UILabel().then {
        $0.text = "사용자님을 위한 추천 음식"
        $0.font = .boldSystemFont(ofSize: 21)
        $0.textAlignment = .center
        $0.textColor = .black
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "추천 음식을 바탕으로 맛잇는 음식을 요리해보세요!"
        $0.font = .boldSystemFont(ofSize: 13)
        $0.textAlignment = .center
        $0.textColor = .lightGray
    }
    
    lazy var dishCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout()).then {
        $0.isPagingEnabled = false
        $0.showsHorizontalScrollIndicator = false
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .pointBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // 수평 스크롤로 변경
        let width = UIScreen.main.bounds.width * 0.7 // 셀 너비를 화면의 80%로 설정
        let height = width * 1.4 // 셀 높이를 셀 너비의 75%로 설정
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 8 // 셀 사이의 간격 설정
        layout.sectionInset = UIEdgeInsets(top: 0, left: (UIScreen.main.bounds.width - width) / 2, bottom: 0, right: (UIScreen.main.bounds.width - width) / 2) // 중앙 정렬을 위한 인셋
        return layout
    }
    
    override func configView() {
        dishCollectionView.backgroundColor = .clear
        dishCollectionView.register(DishCollectionViewCell.self, forCellWithReuseIdentifier: "DishCollectionViewCell")
        dishCollectionView.backgroundColor = .clear
    }
    
    override func configHierarchy() {
        self.addSubviews([
            titleLabel,
            subTitleLabel,
            dishCollectionView
        ])
    }
    
    override func configLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(56)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        dishCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(subTitleLabel.snp.bottom)
            $0.bottom.equalToSuperview().offset(-68)
        }
    }
}
