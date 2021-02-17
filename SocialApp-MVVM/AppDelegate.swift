//
//  AppDelegate.swift
//  SocialApp-MVP
//
//  Created by Oleksandr Bretsko on 2/13/21.
//

import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = mainStoryboard.instantiateViewController(withIdentifier: "PostListVC") as! PostListVC
        
        let netService = NetworkManager.shared
        let viewModel = PostListViewModel(netService)
        rootVC.viewModel = viewModel
        rootVC.netService = netService

        let rootNC = UINavigationController(rootViewController: rootVC)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootNC
        window?.makeKeyAndVisible()
        
        return true
    }
}

