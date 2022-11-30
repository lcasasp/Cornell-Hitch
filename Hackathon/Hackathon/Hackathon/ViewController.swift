//
//  ViewController.swift
//  Hackathon
//
//  Created by Marcel Pantin on 11/30/22.
//

import UIKit

class ViewController: UIViewController {
    let loginButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        
        loginButton.setTitle("Log in", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .systemBlue
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        setUpConstraints()
        
    }
    
    
    @objc
    func didTapLogin(){
        //
        let tabBarVC = UITabBarController()
        let HVC = UINavigationController(rootViewController: HomeVC())
        let SVC = UINavigationController(rootViewController: SettingVC())
        let CVC = UINavigationController(rootViewController: ChatVC())
        
        HVC.title = "Home"
        SVC.title = "Settings"
        CVC.title = "Chat"
        
        
        tabBarVC.setViewControllers([HVC,CVC,SVC], animated: false)
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true)
        
        
        
        guard let items = tabBarVC.tabBar.items else {
            return
        }
        
        let images = ["house","message.circle","gear"]
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: images[i])
        }
        
        
    }
    
    func setUpConstraints(){
        let BHeigth: CGFloat = 50
        let BWidth: CGFloat = 300
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: BWidth),
            loginButton.heightAnchor.constraint(equalToConstant: BHeigth),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }


}


class HomeVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
    }
}

class SettingVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

class ChatVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
    }
}

