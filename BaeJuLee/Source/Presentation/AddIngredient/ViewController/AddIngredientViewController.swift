//
//  AddIngredientViewController.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/22/24.
//

import UIKit
import Tabman
import Pageboy
import SnapKit
import GoogleGenerativeAI
import Toast

class AddIngredientViewController: TabmanViewController {

    var viewControllers: [UIViewController] = []

    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configSearchBar()
        configViewControllers()
        configTabman()
//        configTapGesture()
        configNav()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateDoneButtonState), name: .selectedIngredientsChanged, object: nil)
        updateDoneButtonState()
    }
    
    func configSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "검색"
        searchBar.sizeToFit()
        searchBar.showsCancelButton = false
        navigationItem.titleView = searchBar
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(triggergenerativeAIModelCall))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getAllSelectedIngredients() -> String {
        let allSelectedIngredients = SelectedIngredientsManager.shared.selectedIngredients
        let ingredientsString = allSelectedIngredients.joined(separator: ", ")
        return ingredientsString
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

       
        SelectedIngredientsManager.shared.selectedIngredients = []
    }
    
    @objc func triggergenerativeAIModelCall() {
        UserDefaultsManager.shared.resetRecommendationCountIfNeeded()
                    
        let count = UserDefaultsManager.shared.getRecommendationCount()
        
        if count >= 5 {
            self.view.makeToast("하루 추천 제한을 초과했습니다.\n내일 다시 시도해주세요.", position: .center)
            return
        }
        
        UserDefaultsManager.shared.incrementRecommendationCount()

        
        let loadingVC = DishRecommendViewController()
        navigationController?.pushViewController(loadingVC, animated: true)

        Task {
            let dishNames = await generativeAIModel()
            var dishImages: [String: String] = [:]
            let group = DispatchGroup()

            for dishName in dishNames {
                group.enter()
                CustomSearchJSONAPIManager.shared.searchJSONImage(query: dishName) { result in
                    switch result {
                    case .success(let searchResult):
                        if let imageUrl = searchResult.items.first?.pagemap.cseImage.first?.src {
                            dishImages[dishName] = imageUrl
                        } else {
                            print("음식 이미지가 애초에 존재하지 않음: \(dishName)")
                        }
                    case .failure(let error):
                        print("음식 이미지 fetch 실패: \(dishName): \(error)")
                    }
                    group.leave()
                }
            }

            group.notify(queue: .main) {
                loadingVC.handleNetworkResponse(result: dishImages)
            }
        }
    }

    func generativeAIModel() async -> [String] {
        let model = GenerativeModel(name: "gemini-pro", apiKey: GeminiAPIKey.default)
        let ingredientsString = getAllSelectedIngredients()
        let prompt = "단답형으로만 대답해. '\(ingredientsString)'로 만들수있는 5개 미만의 요리를 '-'을 이용해서 나열해. 이상한 요리 이름 가지고 오지마. 실제로 한국인들이 자주먹는 요리만 추천해. 예를 들어 '스팸', '계란'이 주어지면 '스팸 계란 볶음밥', '계란말이', '계란국'을 추천하면 돼."

        do {
            let response = try await model.generateContent(prompt)
            if let text = response.text {
                print("text: \(text)")
                let dishesArray = text
                    .split(separator: "\n")
                    .map { String($0).trimmingCharacters(in: CharacterSet(charactersIn: "- ").union(.whitespaces)) }
                return dishesArray
            }
        } catch {
            print("API call failed: \(error)")
            return []
        }
        return []
    }
    
    
    func configViewControllers() {
        // 개별 카테고리 배열
        let categoriesData = [
            ("채소", vegetable),
            ("과일", fruits),
            ("정육/계란", meat),
            ("해산물", seafood),
            ("유제품", dairyProduct),
            ("양념", sauce),
            ("통조림", can),
            ("쌀", rice),
            ("김치/반찬", kimchi_deli),
            ("간편식", convenienceFood),
            ("면류", noodle),
            ("과자/간식", snack),
            ("베이커리", bread),
            ("기타", etc)
        ]

        // 모든 카테고리의 합집합을 계산하여 allCategory를 생성
        let allCategory = Set(categoriesData.flatMap { $0.1 }).sorted(by: { $0.ingredientName < $1.ingredientName })

        // '전체' 카테고리를 포함하여 viewControllers 배열 구성
        var categories = [("전체", allCategory)]
        categories.append(contentsOf: categoriesData)

        viewControllers = categories.map { title, ingredients in
            IngredientsViewController(ingredients: ingredients, title: title)
        }
    }

    @objc func updateDoneButtonState() {
        let isEnabled = SelectedIngredientsManager.shared.selectedIngredients.count > 0
        if let customButton = navigationItem.rightBarButtonItem?.customView as? UIButton {
            customButton.isEnabled = isEnabled
            customButton.backgroundColor = isEnabled ? .pointGreen : .superLightGray
            customButton.setTitleColor(isEnabled ? .white : .gray, for: .normal)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func configTabman() {
        self.dataSource = self
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.layout.alignment = .centerDistributed
        bar.layout.interButtonSpacing = 24
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        bar.buttons.customize{
            (button)
            in
            button.tintColor = .pointRegularLightGray
            button.selectedTintColor = .pointGreen
        }
        bar.indicator.tintColor = .pointGreen
        addBar(bar, dataSource: self, at: .top)
    }
    
    func configNav() {
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        // 커스텀 버튼 생성
        let customButton = UIButton(type: .system)
        customButton.setTitle("완료", for: .normal)
        customButton.setTitleColor(.white, for: .normal)
        customButton.backgroundColor = .pointGreen
        customButton.layer.cornerRadius = 15
        customButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        customButton.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        customButton.addTarget(self, action: #selector(triggergenerativeAIModelCall), for: .touchUpInside)

        let doneItem = UIBarButtonItem(customView: customButton)
        navigationItem.rightBarButtonItem = doneItem
    }
    
//    func configTapGesture() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        tapGesture.cancelsTouchesInView = false
//        view.addGestureRecognizer(tapGesture)
//    }
//
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
}

extension AddIngredientViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 현재 활성화된 탭의 ViewController를 찾습니다.
        if let currentIndex = self.currentIndex,
           let ingredientVC = viewControllers[currentIndex] as? IngredientsViewController {
            print("currentIdx: \(currentIndex)")
            if searchText.isEmpty {
                ingredientVC.resetFilteredContent()
            } else {
                ingredientVC.filterContentForSearchText(searchText)
            }
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension AddIngredientViewController: TMBarDataSource, PageboyViewControllerDataSource {
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return .first
    }

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = viewControllers[index].title ?? ""
        return TMBarItem(title: title)
    }
}
