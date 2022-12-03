//
//  TabBarController.swift
//  Hackathon
//
//  Created by Josh Magazine on 12/2/22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tabBarVC = UITabBarController()
        let HVC = UINavigationController(rootViewController: HomeVC())
        let SVC = UINavigationController(rootViewController: SettingVC())
        let CVC = UINavigationController(rootViewController: ChatVC())
        
        HVC.title = "Home"
        SVC.title = "Settings"
        CVC.title = "Chat"
        
        
        tabBarVC.setViewControllers([HVC,CVC,SVC], animated: false)
        tabBarVC.modalPresentationStyle = .fullScreen
        
        
        
        guard let items = tabBarVC.tabBar.items else {
            return
        }
        
        let images = ["house","message.circle","gear"]
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: images[i])
        }
        
        view.addSubview(tabBarVC)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
