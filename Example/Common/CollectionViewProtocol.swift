//
//  CollectionViewProtocol.swift
//  Example
//
//  Created by Rusell on 28.07.2022.
//

import UIKit

protocol CollectionViewCell {
    func configure(with item: CollectionViewItem)
}

protocol CollectionViewItem {
    var cellHeight: CGFloat { get }
    var cellType: (UICollectionViewCell & CollectionViewCell).Type { get }
}

extension CollectionViewItem {
    var cellHeight: CGFloat {
        return UITableView.automaticDimension
    }
}
