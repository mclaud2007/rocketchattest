//
//  UsersListViewController.swift
//  RocketChat
//
//  Created by Григорий Мартюшин on 20.09.2020.
//

import UIKit

class UsersListViewController: UIViewController {
    // MARK: - Properies
    private let perPage: Int = 50
    private let prefetchOffset: Int = 4
    private var isUsersLoading = false
    private let cellID = "userListCell"
    private var userListView: UsersListView {
        return self.view as! UsersListView
    }
    var viewModel: UsersListViewModel?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Контакты"
        
        userListView.tableView.delegate = self
        userListView.tableView.dataSource = self
        userListView.tableView.prefetchDataSource = self
        userListView.tableView.register(UsersListViewCell.self, forCellReuseIdentifier: cellID)
        
        viewModel?.didViewReady()
        
        // Данные изменились
        viewModel?.itemsChanged = { [weak self] in
            self?.isUsersLoading = false
            self?.userListView.tableView.reloadData()
        }
        
        // В случае, если пропадет интернет выведем надпись оффлайн
        AppManager.shared.isNetworkReachabel.addObservers(self, options: [.new]) { [weak self] (status, _) in
            DispatchQueue.main.async {
                self?.title = (!status ? "Контакты offline" : "Контакты")
            }            
        }
    }
    
    override func loadView() {
        super.loadView()
        self.view = UsersListView()
    }
}

extension UsersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? UsersListViewCell else {
            preconditionFailure()
        }
        
        cell.configureFrom(viewModel?.items[indexPath.row])
        
        return cell
    }
}

extension UsersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        104
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = UserDetailViewController()
        detailViewController.viewModel = UserDetailViewModelImpl(User())
        detailViewController.userID = viewModel?.items[indexPath.row].userID
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension UsersListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({ $0.row }).max() else { return }
        
        let itemsCount = viewModel?.items.count ?? 0
        
        if ((itemsCount > 0 && (itemsCount - prefetchOffset) <= maxSection) && !isUsersLoading) {
            let offset = (Int(itemsCount / perPage) + 1) * perPage
            isUsersLoading = true
            viewModel?.reloadModelWith(limit: perPage, offset: offset)
        }
    }
}
