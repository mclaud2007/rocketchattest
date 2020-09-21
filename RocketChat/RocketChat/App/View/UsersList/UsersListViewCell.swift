//
//  UsersListViewCell.swift
//  RocketChat
//
//  Created by Григорий Мартюшин on 20.09.2020.
//

import UIKit
import Kingfisher

class UsersListViewCell: UITableViewCell {

    // MARK: - Properties
    public lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 32
        image.backgroundColor = .gray
        return image
    }()
    
    public lazy var friendName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .natural
        return label
    }()

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureView()
        self.constraintSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
        self.constraintSetup()
    }
    
    private func configureView() {
        self.addSubview(self.avatarImage)
        self.addSubview(self.friendName)
    }
    
    private func constraintSetup() {
        let safeArea = self.safeAreaLayoutGuide
        let defaultIndent: CGFloat = 20
        
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            self.topAnchor.constraint(equalTo: safeArea.topAnchor),
            
            self.avatarImage.heightAnchor.constraint(equalToConstant: 64),
            self.avatarImage.widthAnchor.constraint(equalToConstant: 64),
            
            self.avatarImage.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: defaultIndent),
            self.avatarImage.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: defaultIndent),
            self.friendName.leftAnchor.constraint(equalTo: self.avatarImage.rightAnchor, constant: defaultIndent),
            self.friendName.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -defaultIndent),
            self.friendName.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: defaultIndent)
        ])
    }
    
    public func configureFrom(_ user: User?) {
        let name = user?.name        
        self.friendName.text = ((name?.isEmpty ?? true) ? "No Name" : name!)
        
        if let avatarImage = user?.userName,
           let avatarURL = URL(string: "https://open.rocket.chat/avatar/" + avatarImage + "?format=jpeg") {
            
            self.avatarImage.kf.setImage(with: avatarURL)
        }
        
    }
    
    override func prepareForReuse() {
        self.friendName.text = ""
        self.avatarImage.image = nil
    }
}
