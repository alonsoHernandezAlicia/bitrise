//
//  TabBarViewController.swift
//  iOSAvanzadoOpenBank
//
//  Created by Ismael Sabri Pérez on 26/7/23.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // HomeView
        let homeViewController = HomeViewController(nibName: "HomeView", bundle: nil)
        homeViewController.tabBarItem = UITabBarItem(title: "Heroes", image: UIImage(named: "tab1"), tag: 0)
        // SettingView
        let settingsViewController = SettingsViewController(nibName: "SettingsView", bundle: nil)
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "tab2"), tag: 1)
        
        // Asignar los viewcontrollers al tab bar. El orden de los view controllers lo marca el orden del array de view controllers
        self.viewControllers = [homeViewController, settingsViewController]
        self.title = "Heroes"
        navigationItem.hidesBackButton = true
        setLogoutButton()
    }
    
    private func setLogoutButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
    }
    
    @objc private func logout() {
        NotificationCenter.default.post(name: .deleteToken, object: nil, userInfo: nil)
        navigationController?.popViewController(animated: true)
    }
}
