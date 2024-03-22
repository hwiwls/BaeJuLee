//
//  CategoryViewController.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/22/24.
//

import UIKit

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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngredientCollectionViewCell", for: indexPath) as! IngredientCollectionViewCell
        
        let ingredient = isFiltering ? filteredIngredients[indexPath.item] : ingredients[indexPath.item]
        cell.ingredientNameLabel.text = ingredient.ingredientName
        cell.ingredientImageView.image = ingredient.ingredientImage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ingredient = isFiltering ? filteredIngredients[indexPath.row] : ingredients[indexPath.row]
        
        if let cell = collectionView.cellForItem(at: indexPath) as? IngredientCollectionViewCell {
            // selectedIngredients에서 현재 선택한 ingredient의 인덱스 찾기
            if let index = selectedIngredients.firstIndex(where: { $0.ingredientName == ingredient.ingredientName }) {
                // 이미 선택된 항목은 selectedIngredients 배열에서 제거
                selectedIngredients.remove(at: index)
                cell.checkBtn.setImage(UIImage(systemName: "checkmark.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.pointRegularLightGray), for: .normal)
            } else {
                selectedIngredients.append(ingredient)
                cell.checkBtn.setImage(UIImage(systemName: "checkmark.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.pointGreen), for: .normal)
            }
        }
    }
}
