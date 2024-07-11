//
//  TabBarController.swift
//  customtextfields
//
//  Created by Anastasia Tochilova  on 01.06.2024.
//
import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customTextFieldVC = ViewController()
        customTextFieldVC.tabBarItem = UITabBarItem(title: "Custom", image: nil, tag: 0)
        
        let counterTextFieldVC = ViewController()
        counterTextFieldVC.tabBarItem = UITabBarItem(title: "Counter", image: nil, tag: 1)
        
        let maskedTextFieldVC = ViewController()
        maskedTextFieldVC.tabBarItem = UITabBarItem(title: "Masked", image: nil, tag: 2)
        
        let linkTextFieldVC = ViewController()
        linkTextFieldVC.tabBarItem = UITabBarItem(title: "Link", image: nil, tag: 3)
        
        let passwordTextFieldVC = ViewController()
        passwordTextFieldVC.tabBarItem = UITabBarItem(title: "Password", image: nil, tag: 4)
        
        viewControllers = [customTextFieldVC, counterTextFieldVC, maskedTextFieldVC, linkTextFieldVC, passwordTextFieldVC]
    }
}
