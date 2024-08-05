//
//  RecipeRecommendViewController.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/11/24.
//

import UIKit
import Lottie
import SnapKit
import Then
import Kingfisher

final class DishRecommendViewController: BaseViewController {
    
    private var dishes: [(name: String, imageUrl: String)] = []

    var animationView = LottieAnimationView()
    
    private var dishView = DishRecommendView().then {
        $0.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
    }
    
    private func configNav() {
        let backImage = UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysOriginal).withTintColor(.pointNavy)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    override func configView() {
        animationView = LottieAnimationView(name: "Animation - 1711202389333")
        animationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        animationView.center = view.center
        animationView.loopMode = .loop
        animationView.play()
        
        dishView.dishCollectionView.delegate = self
        dishView.dishCollectionView.dataSource = self
    }
    
    override func configHierarchy() {
        view.addSubviews([
            animationView,
            dishView
        ])
    }
    
    override func configLayout() {
        dishView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // 네트워크 요청 결과 처리
    func handleNetworkResponse(result: [String: String]) {
        if result.isEmpty {
            animationView.stop()
            animationView.isHidden = true
            
            self.view.makeToast("네트워크 연결에 실패했습니다. 나중에 다시 시도해주세요.")
        } else {
            animationView.stop()
            animationView.isHidden = true
            dishView.isHidden = false
            
            print("네트워크 요청 결과:", result)
            
            dishes = result.map { (name: $0.key, imageUrl: $0.value) }
            dishView.dishCollectionView.reloadData()
        }
    }
}

extension DishRecommendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DishCollectionViewCell", for: indexPath) as! DishCollectionViewCell
        
        let dish = dishes[indexPath.row]
        cell.dishNameLabel.text = dish.name
        cell.dishImageView.kf.setImage(with: URL(string: dish.imageUrl))
        print(URL(string: dish.imageUrl))
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let center = CGPoint(x: scrollView.contentOffset.x + scrollView.bounds.width / 2, y: scrollView.bounds.height / 2)
        if let collectionView = scrollView as? UICollectionView {
            for cell in collectionView.visibleCells {
                let baseOffset = cell.frame.midX - center.x
                let scale = max(1 - abs(baseOffset / scrollView.bounds.width), 0.75)
                cell.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
    }
    
}
