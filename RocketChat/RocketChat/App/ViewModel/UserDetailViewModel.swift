//
//  UserDetailViewModel.swift
//  RocketChat
//
//  Created by Григорий Мартюшин on 21.09.2020.
//

import Foundation

protocol UserDetailViewModel {
    var info: User? { get }
    var infoChanged: (() -> ())? { get set }
    
    func didViewReadyFor(_ userID: String)
}

class UserDetailViewModelImpl: UserDetailViewModel {
    private let model: User
    init(_ model: User) {
        self.model = model
    }
    
    var info: User?
    var infoChanged: (() -> ())?
    
    func didViewReadyFor(_ userID: String) {
        model.loadUserWith(userID) { [weak self] user in
            guard let self = self else { return }
            
            self.info = user
            self.infoChanged?()
        }
    }
}
