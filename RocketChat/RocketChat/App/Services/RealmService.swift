//
//  RealmService.swift
//  RocketChat
//
//  Created by Григорий Мартюшин on 21.09.2020.
//

import Foundation
import Realm
import RealmSwift

class RealmService {
    static var shared = RealmService()
    var realmDeleteMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    var realm: Realm?
    
    init() {
        realm = try? Realm(configuration: realmDeleteMigration)
    }
    
    func get<T: Object>(_ type: T.Type) -> Results<T>? {
        return realm?.objects(type) ?? nil
    }
    
    func set<T: Object>(_ items: T) throws {
        try realm?.write {
            realm?.add(items.self, update: Realm.UpdatePolicy.modified)
        }
    }
    
    func delete<T: Object>(_ items: T) throws {
        try realm?.write {
            realm?.delete(items)
        }
    }
    
    func delete<T: Object>(_ items: Results<T>) throws {
        try realm?.write {
            realm?.delete(items)
        }
    }
}
