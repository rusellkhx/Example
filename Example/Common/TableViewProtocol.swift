//
//  TableViewItem.swift
//  Example
//
//  Created by Rusell on 28.07.2022.
//

import UIKit

protocol TableViewCell {
    func configure(with item: TableViewItem)
}

protocol TableViewItem {
    var cellHeight: CGFloat { get }
    var cellType: (UITableViewCell & TableViewCell).Type { get }
}

extension TableViewItem {
    var cellHeight: CGFloat {
        return UITableView.automaticDimension
    }
}
