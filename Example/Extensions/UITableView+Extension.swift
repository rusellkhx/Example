//
//  UITableView+Extension.swift
//  Example
//
//  Created by Rusell on 28.07.2022.
//

import UIKit

extension UITableView {
    func register(CellClass: UITableViewCell.Type) {
        register(CellClass.self, forCellReuseIdentifier: String(describing: CellClass.self))
    }
    
    func dequeue<CellClass: UITableViewCell>(_ CellClass: CellClass.Type) -> CellClass {
        let cellClassName = String(describing: CellClass.self)
        let cell = dequeueReusableCell(withIdentifier: cellClassName)
        
        guard let typedCell = cell as? CellClass else {
            fatalError("Could not deque cell with type \(CellClass.self)")
        }
        
        return typedCell
    }
    
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }

        return lastIndexPath == indexPath
    }
    
    func configureCell(for item: TableViewItem, indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeue(item.cellType)
        if let cell = cell as? TableViewCell {
            cell.configure(with: item)
        }
        return cell
    }
}

extension UITableViewCell {
    func transform(for view: UIImageView,
                   nameAnimation: String,
                   duration: CFTimeInterval,
                   fromValue: Float,
                   toValue: Float,
                   autoreverses: Bool,
                   repeatCount: Float) {
        let animation = CASpringAnimation(keyPath: nameAnimation)
        
        animation.duration = duration
        animation.fromValue = duration
        animation.toValue = fromValue
        animation.autoreverses = autoreverses
        animation.repeatCount = repeatCount
        view.layer.add(animation, forKey: nil)
    }
}
