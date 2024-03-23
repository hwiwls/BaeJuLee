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
    }
    
    func configSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "검색"
        searchBar.sizeToFit()
        searchBar.showsCancelButton = false
        navigationItem.titleView = searchBar
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(triggerAPICall))
        navigationItem.rightBarButtonItem = doneButton
    }
    
//    @objc func printSelectedItems() {
//        viewControllers.forEach {
//            if let vc = $0 as? IngredientsViewController {
//                vc.selectedIngredients.forEach { ingredient in
//                    print(ingredient.ingredientName)
//                }
//            }
//        }
//    }
    
    func getAllSelectedIngredients() -> String {
        var allSelectedIngredients: [String] = []
        viewControllers.forEach {
            if let vc = $0 as? IngredientsViewController {
                let ingredientNames = vc.selectedIngredients.map { $0.ingredientName }
                allSelectedIngredients.append(contentsOf: ingredientNames)
            }
        }
        let ingredientsString = allSelectedIngredients.joined(separator: ", ")
        return ingredientsString
    }
    
    @objc func triggerAPICall() {
            // Task.init을 사용하여 비동기 작업을 시작합니다.
            Task {
                await performAPICall()
            }
        }
    
    func performAPICall() async {
        
        let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)

        let ingredientsString = getAllSelectedIngredients()
        let prompt = "단답형으로만 대답해. 다음 재료들로 만들 수 있는 음식을 10가지 미만으로 '-'을 이용해서 나열해: \(ingredientsString)."
            do {
                let response = try await model.generateContent(prompt)
                if let text = response.text {
                    DispatchQueue.main.async {
                        
                        print(text)
                        
                        let dishesArray = text
                            .split(separator: "\n")
                            .map { String($0).trimmingCharacters(in: CharacterSet(charactersIn: "- ").union(.whitespaces)) }

                        print(dishesArray)
                    }
                }
            } catch {
                print("API call failed: \(error)")
            }
        }
    
//    @objc func performAPICall() async {
//        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "GEMINI_API_KEY") as? String else { return }
//        let model = GenerativeModel(name: "gemini-pro", apiKey: apiKey)
//        
//        // 선택된 재료들로 구성된 문자열을 prompt로 사용
//        let ingredientsString = getAllSelectedIngredients()
//        let prompt = "단답형으로만 대답해. 다음 재료로 만들 수 있는 음식을 10가지 미만으로 나열해: \(ingredientsString)"
//        
//        do {
//            let response = try await model.generateContent(prompt)
//            let response2 = try await model.countTokens(prompt)
//            print(response2.totalTokens)
//            if let text = response.text {
//                print("gemini: \(text)") // API로부터 받은 응답 처리
//            }
//        } catch {
//            print("API call failed: \(error)")
//        }
//    }
    
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
