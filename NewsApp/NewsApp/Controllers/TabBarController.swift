//
//  TabBarController.swift
//  NewsApp
//
//  Created by Ilgın Akgöz on 7.09.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setUpTabs()
    }
    
    private func setUpTabs() {
        let newsVC = NewsViewController()
        let bookmarksVC = BookmarksViewController()
        let profileVC = ProfileViewController()
        
        newsVC.title = "News"
        bookmarksVC.title = "Bookmarks"
        profileVC.title = "Profile"
        
        newsVC.navigationItem.largeTitleDisplayMode = .automatic
        bookmarksVC.navigationItem.largeTitleDisplayMode = .automatic
        profileVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: newsVC)
        let nav2 = UINavigationController(rootViewController: bookmarksVC)
        let nav3 = UINavigationController(rootViewController: profileVC)
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.newYork(size: 34)!,
        ]
        
        nav1.navigationBar.largeTitleTextAttributes = titleAttributes
        nav2.navigationBar.largeTitleTextAttributes = titleAttributes
        nav3.navigationBar.largeTitleTextAttributes = titleAttributes
        
        nav1.tabBarItem = UITabBarItem(title: "",
                                       image: UIImage(systemName: "newspaper"),
                                       tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "",
                                       image: UIImage(systemName: "bookmark"),
                                       tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "",
                                       image: UIImage(systemName: "person"),
                                       tag: 3)
        
        for nav in [nav1, nav2, nav3] {
            nav.navigationBar.prefersLargeTitles = true
        }

        setViewControllers([nav1, nav2, nav3], animated: true)
    }
}
