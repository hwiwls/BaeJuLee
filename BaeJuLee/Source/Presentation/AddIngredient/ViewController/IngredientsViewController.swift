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
}

extension IngredientsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngredientCollectionViewCell", for: indexPath) as! IngredientCollectionViewCell
        
        let ingredient = ingredients[indexPath.item]
        cell.ingredientNameLabel.text = ingredient.ingredientName
        cell.ingredientImageView.image = ingredient.ingredientImage
        
        return cell
    }
}
