//
//  StorageService.swift
//  Example
//
//  Created by Rusell on 31.07.2022.
//

import Foundation
import RealmSwift

protocol StorageService: AnyObject {
    func store(users: [RealmUser])
    func subscribeOnUsers(completion: @escaping (Results<RealmUser>) -> Void)
    func unsubscribeFromUsers()
    func getLastUpdateDate() -> Date?
    func storeLastUpdateDate()
    func loadUser(id: Int) -> RealmUser?
}

final class StorageServiceImpl: StorageService {

    // MARK: - Private properties

    private var token: NotificationToken?

    // MARK: - StorageService

    func store(users: [RealmUser]) {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let realm = getRealm()
        try! realm.write {
            realm.delete(realm.objects(RealmUser.self))
            realm.add(users)
        }
    }

    func subscribeOnUsers(completion: @escaping (Results<RealmUser>) -> Void) {
        token = getRealm().objects(RealmUser.self).observe { changes in
            switch changes {
            case .error(let error):
                print(error)
            case .initial(let users), .update(let users, _, _, _):
                completion(users)
            }
        }
    }

    func unsubscribeFromUsers() {
        token?.invalidate()
    }

    func getLastUpdateDate() -> Date? {
        let realm = getRealm()
        guard let lastUpdateDate = realm.objects(SaveDate.self).first
            else { return nil }
        return lastUpdateDate.dateTime
    }

    func storeLastUpdateDate() {
        let realm = getRealm()
        try! realm.write {
            realm.delete(realm.objects(SaveDate.self))
            realm.add(SaveDate())
        }
    }

    func loadUser(id: Int) -> RealmUser? {
        return getRealm().object(ofType: RealmUser.self, forPrimaryKey: id)
    }

    // MARK: - Private functions

    private func getRealm() -> Realm {
        do {
            return try Realm()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

