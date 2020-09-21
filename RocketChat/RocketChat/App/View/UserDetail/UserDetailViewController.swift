//
//  UserDetailViewController.swift
//  RocketChat
//
//  Created by Григорий Мартюшин on 20.09.2020.
//

import UIKit

class UserDetailViewController: UIViewController {
    var userID: String?
    var viewModel: UserDetailViewModel?
    
    private var userDetailView: UserDetailView {
        return self.view as! UserDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.infoChanged = { [weak self] in
            guard let self = self else { return }
            
            let userInfo: User? = self.viewModel?.info
            
            self.userDetailView.lblName.text = ((userInfo?.name ?? "").isEmpty ? "No name" : userInfo?.name)
            self.userDetailView.lblUserName.text = userInfo?.userName ?? ""
            self.userDetailView.lblUtcOffset.text = String(userInfo?.utcOffset ?? -1)
            
            if let avatarImage = userInfo?.userName,
               let avatarURL = URL(string: "https://open.rocket.chat/avatar/" + avatarImage + "?format=jpeg") {
                self.userDetailView.avatarImage.kf.setImage(with: avatarURL)
            }
        }
        
        // В случае изменения статуса сети добавим в заголовок окна информацию
        AppManager.shared.isNetworkReachabel.addObservers(self, options: [.new]) { [weak self] (status, _) in
            DispatchQueue.main.async {
                self?.title = (!status ? "Offline" : "")
            }
        }

        // Пытаемся получить данные о пользователе
        if let userID = userID {
            viewModel?.didViewReadyFor(userID)
        } else {
            showErrorMessage(message: "Данные о пользователе не найдены")
        }
    }
    
    override func loadView() {
        super.loadView()
        self.view = UserDetailView()
    }

}
