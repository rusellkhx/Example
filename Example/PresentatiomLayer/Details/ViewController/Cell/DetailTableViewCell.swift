//
//  DetailTableViewCell.swift
//  Example
//
//  Created by Rusell on 31.07.2022.
//

import UIKit
import SnapKit

final class DetailTableViewCell: UITableViewCell {
    
    // MARK: - Private properties
    
    private let constants = Constants()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = FieldsConstants.defaultText
        titleLabel.font = .systemFont(ofSize: 15.0, weight: .regular)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = .rbMainTexts
        titleLabel.textAlignment = .right
        
        return titleLabel
    }()
    
    private lazy var valueLabel: UILabel = {
        let valueLabel = UILabel()
        valueLabel.text = FieldsConstants.defaultText
        valueLabel.font = .systemFont(ofSize: 17.0, weight: .regular)
        valueLabel.textAlignment = .left
        valueLabel.numberOfLines = 0
        valueLabel.lineBreakMode = .byWordWrapping
        
        return valueLabel
    }()
    
    private var item: DetailsItem?

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureElements()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func configureElements() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(constants.fromLeftRight)
            $0.right.equalTo(valueLabel.snp.left).offset(-constants.fromLeftRight)
            $0.centerY.equalToSuperview()
        }

        valueLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(constants.fromLeftForField)
            $0.right.equalToSuperview().offset(-constants.fromLeftRight)
            $0.top.equalToSuperview().offset(constants.fromTop)
            $0.bottom.equalToSuperview().offset(-constants.fromTop)
        }
    }
}

// MARK: - TableViewCell

extension DetailTableViewCell: TableViewCell {
    func configure(with item: TableViewItem) {
        guard let item = item as? DetailsItem else { return }
        titleLabel.text = item.title
        switch item.textType {
        case .plain(let text):
            valueLabel.textColor = item.isAction ?? false ? .systemBlue : .rbDarkText
            valueLabel.attributedText = nil
            valueLabel.text = text
        case .attributed(let attributedText):
            valueLabel.text = nil
            valueLabel.attributedText = attributedText
        }
        selectionStyle = item.didSeletectItem == nil ? .none : .default
    }
}

extension DetailTableViewCell {
    private struct Constants {
        let fromLeftRight = 20
        let fromTop = 5
        let fromLeftForField = 120
    }
}
