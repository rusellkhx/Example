//
//  DetailsItem.swift
//  Example
//
//  Created by Rusell on 31.07.2022.
//

import UIKit

struct DetailsItem: TableViewItem {
    enum TextType {
        case plain(String)
        case attributed(NSAttributedString)
    }
    
    var title: String
    var textType: TextType
    var isAction: Bool?
    
    // MARK: - UserDetailsItem
    
    var didSeletectItem: Completion?
    let cellType: (UITableViewCell & TableViewCell).Type = DetailTableViewCell.self
    
    // MARK: - Lifecycle
    
    init(title: String, textType: TextType, isAction: Bool? = false, didSeletectItem: Completion? = nil) {
        self.title = title
        self.textType = textType
        self.isAction = isAction
        self.didSeletectItem = didSeletectItem
    }
}
