//
//  UsersList.swift
//  RocketChat
//
//  Created by Григорий Мартюшин on 20.09.2020.
//

import Foundation

class UsersList {
    let service = UserService()
    var items: Observable<[User]?> = Observable(nil)
    
    func loadData(limit: Int = 50, offset: Int = 0, completion: @escaping (([User]?) -> ())) {
        let isNetworkReacheble = AppManager.shared.isNetworkReachabel
        
        // Подписываемся на обновления списка пользователей
        items.addObservers(self, options: [.new]) { (user, _) in
            completion(user)
        }
        
        // Загружаем список пользователей из сети
        if isNetworkReacheble.value {
            service.loadUsersFromNetwork(room: "general", limit: limit, offset: offset) { [weak self] (users, error) in
                self?.items.value = users
            }

        } else {
            service.loadUsersFromDataBase { [weak self] (users) in
                self?.items.value = users
            }
        }
    }
}
