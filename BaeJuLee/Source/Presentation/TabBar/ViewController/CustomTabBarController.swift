//
//  TabBarViewController.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/11/24.
//

import UIKit
import RealmSwift

final class CustomTabBarController: UITabBarController {
    
    private let middleButton = UIButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 52, height: 52)
        $0.backgroundColor = .pointNavy
        $0.layer.cornerRadius = 26
        $0.setImage(UIImage(systemName: "plus")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarConfig()
        setupMiddleButton()
        
        let realm = try! Realm()
        print(realm.configuration.fileURL ?? "")
    }
    
    private func tabBarConfig() {
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
        tabBar.tintColor = .pointGreen
        tabBar.isTranslucent = false
        
        let overviewViewController = UINavigationController(
            rootViewController: OverviewViewController()
        )
        
        let calendarViewController = UINavigationController(
            rootViewController: CalendarViewController()
        )
        
        let addMealViewController = UINavigationController(
            rootViewController: AddMealViewController()
        )
        
        let addIngredintViewController = UINavigationController(
            rootViewController: AddIngredientViewController()
        )
        
        let likeViewController = UINavigationController(
            rootViewController: LikeViewController()
        )
        
        overviewViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "house")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.lightGray),
            selectedImage: UIImage(systemName: "house")
        )
        
        
        calendarViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "calendar")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.lightGray),
            selectedImage: UIImage(systemName: "calendar")
        )
        
        addMealViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "plus")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.black),
            selectedImage: UIImage(systemName: "plus")
        )
        
        addIngredintViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "fork.knife")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.lightGray),
            selectedImage: UIImage(systemName: "fork.knife")
        )
        
        likeViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "heart.fill")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.lightGray),
            selectedImage: UIImage(systemName: "heart.fill")
        )
        
        
        let tabItems = [
            overviewViewController,
            calendarViewController,
            addMealViewController,
            addIngredintViewController,
            likeViewController
        ]
        
        setViewControllers(tabItems, animated: true)
    }
    
    private func setupMiddleButton() {
        var middleButtonFrame = middleButton.frame
        middleButtonFrame.origin.y = view.bounds.height - middleButtonFrame.height - tabBar.frame.height
        middleButtonFrame.origin.x = view.bounds.width/2 - middleButtonFrame.width/2
        middleButton.frame = middleButtonFrame
        
        middleButton.addTarget(self, action: #selector(middleButtonAction), for: .touchUpInside)
        
        view.addSubview(middleButton)
        view.layoutIfNeeded()
    }
    
    @objc func middleButtonAction(sender: UIButton) {
        let vc = AddMealViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated:  true)
    }
}

