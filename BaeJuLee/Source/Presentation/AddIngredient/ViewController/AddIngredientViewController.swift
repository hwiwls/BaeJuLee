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

class AddIngredientViewController: TabmanViewController {

    var viewControllers: [UIViewController] = []

    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configSearchBar()
        configViewControllers()
        configTabman()
    }
    
    func configSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "검색"
        searchBar.sizeToFit()
        searchBar.showsCancelButton = true
        navigationItem.titleView = searchBar
    }
    
    func configViewControllers() {
        let categories = [
            ("전체", allCategory),
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
    
}

extension AddIngredientViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
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
