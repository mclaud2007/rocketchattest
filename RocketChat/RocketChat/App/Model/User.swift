//
//  User.swift
//  RocketChat
//
//  Created by Григорий Мартюшин on 20.09.2020.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var userID: String
    @objc dynamic var status: String
    @objc dynamic var name: String?
    @objc dynamic var utcOffset: Int
    @objc dynamic var userName: String?
    
    override class func primaryKey() -> String? {
        return "userID"
    }
    
    init(userID: String, status: String, name: String? = nil, utcOffset: Int? = nil, userName: String?) {
        self.userID = userID
        self.status = status
        self.name = name
        self.utcOffset = utcOffset ?? -1
        self.userName = userName
    }
    
    required init() {
        self.userID = ""
        self.status = ""
        self.name = ""
        self.utcOffset = -1
        self.userName = ""
    }
    
    init(from json: [String: AnyObject]) {
        self.userID = (json["_id"] as? String ?? "")
        self.status = (json["status"] as? String ?? "")
        self.name = (json["name"] as? String ?? "")
        self.utcOffset = (json["utcOffset"] as? Int ?? -1)
        self.userName = (json["username"] as? String ?? "")
    }
    
    func loadUserWith(_ userID: String, completion: @escaping ((User?) -> Void)) {
        let service = UserService()
        let user = service.loadUserBy(userId: userID)
        
        completion(user)
    }
}
