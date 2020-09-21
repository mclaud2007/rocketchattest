//
//  UserDetailView.swift
//  RocketChat
//
//  Created by Григорий Мартюшин on 21.09.2020.
//

import UIKit

class UserDetailView: UIView {
    private let avatarHeight: CGFloat = 80.0
    private let defaultInsets: CGFloat = 10.0

    // MARK: - Subviews
    private(set) lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = avatarHeight / 2
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .gray
        return image
    }()
    
    // ФИО
    private(set) lazy var  lblName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Заголовок "Никнейм"
    private lazy var  lblUserNameTitle: UILabel = {
        let label = UILabel()
        label.text = "Никнейм"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Никнейм
    private(set) lazy var  lblUserName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Заголовок "UTCOffset"
    private lazy var  lblUtcOffsetTitle: UILabel = {
        let label = UILabel()
        label.text = "UTCOffset"
        label.textColor = .systemGray
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // UTCOffset
    private(set) lazy var  lblUtcOffset: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureUI()
    }
    
    private func configureUI() {
        self.backgroundColor = .white
        self.addAvatar()
        self.addLblName()
        self.addLblUserNameTitle()
        self.addLblUserName()
        self.addLblOffsetTitle()
        self.addLblOffset()
    }
    
    private func addAvatar() {
        let safeArea = self.safeAreaLayoutGuide
        self.addSubview(self.avatarImage)
        
        NSLayoutConstraint.activate([
            self.avatarImage.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: defaultInsets),
            self.avatarImage.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: defaultInsets),
            self.avatarImage.heightAnchor.constraint(equalToConstant: avatarHeight),
            self.avatarImage.widthAnchor.constraint(equalTo: self.avatarImage.heightAnchor, multiplier: 1)
        ])
    }
    
    private func addLblName() {
        self.addSubview(lblName)
        
        NSLayoutConstraint.activate([
            self.lblName.leftAnchor.constraint(equalTo: self.avatarImage.rightAnchor, constant: defaultInsets),

            // Центрируем относительно аватара
            NSLayoutConstraint(item: self.lblName, attribute: .centerY, relatedBy: .equal,
                               toItem: self.avatarImage, attribute: .centerY,
                               multiplier: 1, constant: 0
            ),
        ])
    }
    
    private func addLblUserNameTitle() {
        let safeArea = safeAreaLayoutGuide
        self.addSubview(lblUserNameTitle)
        
        NSLayoutConstraint.activate([
            self.lblUserNameTitle.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: defaultInsets),
            self.lblUserNameTitle.topAnchor.constraint(equalTo: self.avatarImage.bottomAnchor, constant: defaultInsets),
            self.lblUserNameTitle.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -defaultInsets)
        ])
    }
    
    private func addLblUserName() {
        let safeArea = safeAreaLayoutGuide
        addSubview(lblUserName)
        
        NSLayoutConstraint.activate([
            self.lblUserName.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: defaultInsets),
            self.lblUserName.topAnchor.constraint(equalTo: self.lblUserNameTitle.bottomAnchor, constant: defaultInsets)
        ])
    }

    private func addLblOffsetTitle() {
        let safeArea = safeAreaLayoutGuide
        addSubview(lblUtcOffsetTitle)
        
        NSLayoutConstraint.activate([
            self.lblUtcOffsetTitle.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: defaultInsets),
            self.lblUtcOffsetTitle.topAnchor.constraint(equalTo: self.lblUserName.bottomAnchor, constant: defaultInsets),
            self.lblUtcOffsetTitle.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -defaultInsets)
        ])
    }
    
    private func addLblOffset() {
        let safeArea = safeAreaLayoutGuide
        addSubview(lblUtcOffset)
        
        NSLayoutConstraint.activate([
            self.lblUtcOffset.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: defaultInsets),
            self.lblUtcOffset.topAnchor.constraint(equalTo: self.lblUtcOffsetTitle.bottomAnchor, constant: defaultInsets)
        ])
    }
}
