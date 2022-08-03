//
//  UICollectionView+Extension.swift
//  Example
//
//  Created by Rusell on 28.07.2022.
//

import UIKit

extension UICollectionView {
    func register(CellClass: UICollectionViewCell.Type) {
        register(CellClass.self, forCellWithReuseIdentifier: String(describing: CellClass.self))
    }

    func dequeue<CellClass: UICollectionViewCell>(_ CellClass: CellClass.Type, for indexPath: IndexPath) -> CellClass {
        let cellClassName = String(describing: CellClass.self)
        let cell = dequeueReusableCell(withReuseIdentifier: cellClassName, for: indexPath)
        guard let typedCell = cell as? CellClass else {
            fatalError("Could not deque cell with type \(CellClass.self)")
        }
        return typedCell
    }
}
