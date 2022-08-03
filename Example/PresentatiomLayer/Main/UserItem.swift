//
//  UserItem.swift
//  Example
//
//  Created by Rusell on 28.07.2022.
//

import UIKit

struct UserItem: TableViewItem {
    var id: Int
    var name: String
    var age: Int
    var gender: String
    var email: String
    var phone: String
    var image: String
    
    // MARK: - UserDetailsItem
    
    var didSeletectItem: Completion?
    let cellType: (UITableViewCell & TableViewCell).Type = MainTableViewCell.self
    
    // MARK: - Lifecycle
    
    init(user: RealmUser, didSeletectItem: Completion? = nil) {
        self.id = user.id
        self.name = user.name
        self.age = user.age
        self.gender = user.gender
        self.email = user.email
        self.phone = user.phone
        self.image = user.image
        self.didSeletectItem = didSeletectItem
    }
}
