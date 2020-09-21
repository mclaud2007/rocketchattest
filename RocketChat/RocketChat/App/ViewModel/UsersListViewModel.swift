//
//  UsersListViewModel.swift
//  RocketChat
//
//  Created by Григорий Мартюшин on 20.09.2020.
//

import Foundation

protocol UsersListViewModel {
    var items: [User] { get }
    var itemsChanged: (() -> ())? { get set }
    
    func didViewReady()
    func reloadModelWith(limit: Int, offset: Int)
}

class UsersListViewModelImpl: UsersListViewModel {
    private let model: UsersList
    init(_ model: UsersList) {
        self.model = model
    }
    
    var items: [User] = []
    var itemsChanged: (() -> ())?
    
    func didViewReady() {
        model.loadData { users in
            guard let users = users else {
                return
            }
            
            self.items = users
            self.itemsChanged?()
        }
    }
    
    func reloadModelWith(limit: Int, offset: Int) {
        model.loadData(limit: limit, offset: offset) { users in
            guard let users = users else {
                return
            }
            
            users.forEach { user in
                self.items.append(user)
            }
            
            self.itemsChanged?()
        }
    }
}
