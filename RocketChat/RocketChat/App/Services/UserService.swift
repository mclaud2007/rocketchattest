//
//  UserService.swift
//  RocketChat
//
//  Created by Григорий Мартюшин on 20.09.2020.
//

import Foundation
import Alamofire

class UserService {
    private let apiUserId = ""
    private let apiAuthToken = ""
    private let apiScheme = "https"
    private let apiHost = "open.rocket.chat"
    private let apiPath = "/api/v1/"
    
    private let realm = RealmService.shared
    
    enum UserServiceError: Error {
        case userListIsEmpty
    }
    
    func buildURLFor(method: String, parameter: [URLQueryItem]?) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = apiScheme
        urlComponents.host = apiHost
        urlComponents.path = "\(apiPath)\(method)"
        
        if let parameter = parameter {
            urlComponents.queryItems = parameter
        }
        
        return urlComponents
    }
    
    func loadUsersFromDataBase(completion: (([User]?) -> Void)? = nil) {
        if let users = realm.get(User.self) {
            var result: [User] = []
            
            users.forEach { user in
                result.append(user)
            }
            
            completion?(result)
        }
    }
    
    
    func loadUsersFromNetwork(room: String,
                       limit: Int = 50,
                       offset: Int = 0,
                       completion: (([User]?, Error?) -> Void)? = nil) {
        
        let parameter = [URLQueryItem(name: "roomName", value: room),
                         URLQueryItem(name: "limit", value: String(limit)),
                         URLQueryItem(name: "offset", value: String(offset))
        ]
        
        let url = buildURLFor(method: "channels.members", parameter: parameter)
        
        AF.request(url, method: .get,
                   headers: ["X-User-Id": apiUserId,
                             "X-Auth-Token": apiAuthToken])
            .responseJSON { [weak self] response in
                guard let self = self else { return }
                
                switch response.result {
                case .success(let usersData):
                    
                    // Парсим ответ
                    if let responseJSON = usersData as? [String: AnyObject],
                       let success = responseJSON["success"] as? Int, success == 1,
                       let totalUser = responseJSON["total"] as? Int, totalUser > 0,
                       let members = responseJSON["members"] as? [[String: AnyObject]] {
                                            
                        let results = members.map { (data) -> User in
                            let user = User(from: data)
                            try? self.realm.set(user)
                            return user
                        }
                        
                        completion?(results, nil)
                        
                    } else {
                        completion?(nil, UserServiceError.userListIsEmpty)
                    }
                case .failure(let error):
                    completion?(nil, error)
                    break
                }
                
        }
    }
    
    func loadUserBy(userId: String) -> User? {
        if let result = realm.get(User.self)?.filter("userID = '\(userId)'").first {
            return result
        }
        
        return nil
    }
}
