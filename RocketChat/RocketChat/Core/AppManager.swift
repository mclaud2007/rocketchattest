//
//  AppManager.swift
//  RocketChat
//
//  Created by Григорий Мартюшин on 20.09.2020.
//

import Foundation
import UIKit
import Network

final class AppManager {
    static var shared = AppManager()
    var window: UIWindow?
    let monitor = NWPathMonitor()
    let isNetworkReachabel: Observable<Bool> = Observable(false)
    
    func start(with window: UIWindow?) {
        let usersList = UsersList()
        let usersListViewModel = UsersListViewModelImpl(usersList)
        let userViewController = UsersListViewController()
        userViewController.viewModel = usersListViewModel
        
        let navigationController = UINavigationController(rootViewController: userViewController)
        
        // Мониторинг доступности сети
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.isNetworkReachabel.value = true
            } else {
                self?.isNetworkReachabel.value = false
            }
        }
        
        let queue = DispatchQueue(label: "monitor")
        monitor.start(queue: queue)
        
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
    }
    
}
