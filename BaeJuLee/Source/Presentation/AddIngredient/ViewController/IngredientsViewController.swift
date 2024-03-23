//
//  CategoryViewController.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/22/24.
//

import UIKit
import Toast

final class IngredientsViewController: BaseViewController {
    lazy var ingredientCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    var ingredients: [Ingredient] = []
    var filteredIngredients: [Ingredient] = []  // 재료 검색
    var isFiltering: Bool = false
    var selectedIngredients: [Ingredient] = [] // 선택된 재료
    
    init(ingredients: [Ingredient], title: String) {
        super.init(nibName: nil, bundle: nil)
        self.ingredients = ingredients
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(handleIngredientsChanged), name: .selectedIngredientsChanged, object: nil)
    }

    @objc func handleIngredientsChanged() {
        // 변경 사항에 대한 처리를 수행, 예를 들면 컬렉션 뷰 업데이트
        ingredientCollectionView.reloadData()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: 76)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
        
    
    override func configView() {
        ingredientCollectionView.register(IngredientCollectionViewCell.self, forCellWithReuseIdentifier: "IngredientCollectionViewCell")
        ingredientCollectionView.delegate = self
        ingredientCollectionView.dataSource = self
        ingredientCollectionView.backgroundColor = .clear
    }
    
    override func configHierarchy() {
        view.addSubview(ingredientCollectionView)
    }
    
    override func configLayout() {
        ingredientCollectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide) 
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        if searchText.isEmpty {
            isFiltering = false
        } else {
            filteredIngredients = ingredients.filter { $0.ingredientName.contains(searchText) }
            // 검색된 결과의 존재 여부에 관계없이 검색 모드로 전환
            isFiltering = true
        }
        ingredientCollectionView.reloadData()
    }

    func resetFilteredContent() {
        isFiltering = false
        ingredientCollectionView.reloadData()
    }

}

extension IngredientsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltering ? filteredIngredients.count : ingredients.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngredientCollectionViewCell", for: indexPath) as? IngredientCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let ingredient = isFiltering ? filteredIngredients[indexPath.item] : ingredients[indexPath.item]
        let isSelected = SelectedIngredientsManager.shared.isSelected(ingredient.ingredientName)
        cell.configure(with: ingredient, isSelected: isSelected)
        
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ingredient = isFiltering ? filteredIngredients[indexPath.row] : ingredients[indexPath.row]
        
        // 선택 상태 토글
        let updated = SelectedIngredientsManager.shared.toggleIngredient(ingredient.ingredientName)
        
        if !updated {
            // 선택 제한에 도달했을 경우 알림
            self.view.makeToast("최대 10개의 재료만 선택할 수 있습니다.")
        } else {
            // UI 업데이트
            collectionView.reloadData()
        }
    }

}
