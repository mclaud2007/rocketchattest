//
//  UsersListView.swift
//  RocketChat
//
//  Created by Григорий Мартюшин on 20.09.2020.
//

import UIKit

class UsersListView: UIView {
    
    // MARK: - Subviews
    let tableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureUI()
    }
    
    private func configureUI() {
        self.addTableView()
        self.setupConstraints()
    }
    
    private func addTableView() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.isUserInteractionEnabled = true
        self.addSubview(self.tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.topAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

}
