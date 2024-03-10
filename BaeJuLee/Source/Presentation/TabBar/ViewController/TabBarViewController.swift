//
//  TabBarViewController.swift
//  BaeJuLee
//
//  Created by hwijinjeong on 3/11/24.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarConfig()
        
        view.backgroundColor = .white
    }
    
    private func tabBarConfig() {
        tabBar.barTintColor = UIColor.customColor.backgroundColor
        tabBar.tintColor = UIColor.customColor.pointGreenColor
        tabBar.isTranslucent = false
        
        let overviewViewController = UINavigationController(
            rootViewController: OverviewViewController()
        )
        
        let calendarViewController = UINavigationController(
            rootViewController: CalendarViewController()
        )
        
        let recipeRecommendViewController = UINavigationController(
            rootViewController: RecipeRecommendViewController()
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
        
        recipeRecommendViewController.tabBarItem = UITabBarItem(
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
            recipeRecommendViewController,
            likeViewController
        ]
        
        setViewControllers(tabItems, animated: true)
    }
    
    
}
