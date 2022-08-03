//
//  MainTableViewCell.swift
//  Example
//
//  Created by Rusell on 28.07.2022.
//

import UIKit
import SnapKit

final class MainTableViewCell: UITableViewCell {

    // MARK: - Private properties
    
    private lazy var cornerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.roundCorners(.allCorners, radius: constants.cornerRadius)
        view.addShadow(shadowColor: UIColor.rbShadow.cgColor,
                       shadowOffset: constants.shadowOffset,
                       shadowOpacity: constants.shadowOpacity,
                       shadowRadius: constants.shadowRadius)
        return view
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = constants.contentStackViewSpacing
        return stackView
    }()
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var item: UserItem?
    private let constants = Constants()

    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value2, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    
    private func setupUI() {
        selectionStyle = .none
        contentView.backgroundColor = .clear
        
        contentView.addSubview(cornerView)
        cornerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(constants.cornerViewVerticalOffset)
            $0.left.equalToSuperview().offset(constants.cornerViewOffset)
            $0.right.equalToSuperview().offset(-constants.cornerViewOffset)
            $0.bottom.equalToSuperview().offset(-constants.cornerViewHorisontalOffset)
        }
        
        cornerView.addSubview(contentStackView)
        contentStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(constants.contentStackViewTopConstraint)
            $0.right.equalToSuperview().offset(-constants.contentStackViewOffsetConstraint)
            $0.bottom.equalToSuperview().offset(-constants.contentStackViewOffsetConstraint)
        }
        
        cornerView.addSubview(userImageView)
        userImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(constants.contentStackViewTopConstraint)
            $0.left.equalToSuperview().offset(constants.contentStackViewOffsetConstraint)
            $0.right.equalTo(contentStackView.snp.left).offset(-constants.contentStackViewOffsetConstraint)
            $0.height.equalTo(constants.heightPlayerImageView)
            $0.width.equalTo(constants.widthPlayerImageView)
        }
    }
    
    private func createView(title: String? = nil, text: String?, font: UIFont?, color: UIColor? = nil) -> UIView? {
        guard let text = text else { return nil }
        
        let view = UIView()
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.font = font ?? UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = color ?? .rbMainTexts
        if let title = title {
            titleLabel.text = title + " " + text
        } else {
            titleLabel.text = text
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        return view
    }
}

// MARK: - TableViewCell

extension MainTableViewCell: TableViewCell {
    func configure(with item: TableViewItem) {
        guard let item = item as? UserItem else { return }
        
        userImageView.url(item.image)
        userImageView.setRounded()
        
        contentStackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        if let view = createView(text: String(item.name),
                                 font: UIFont.systemFont(ofSize: 24),
                                 color: .rbDarkText) {
            contentStackView.addArrangedSubview(view)
        }
        if let view = createView(title: FieldsConstants.age,
                                 text: String(item.age),
                                 font: UIFont.systemFont(ofSize: 14)) {
            contentStackView.addArrangedSubview(view)
        }
        if let view = createView(title: FieldsConstants.gender,
                                 text: String(item.gender),
                                 font: UIFont.systemFont(ofSize: 14)) {
            contentStackView.addArrangedSubview(view)
        }
        if let view = createView(title: FieldsConstants.email,
                                 text: String(item.email),
                                 font: UIFont.systemFont(ofSize: 14)) {
            contentStackView.addArrangedSubview(view)
        }
        if let view = createView(title: FieldsConstants.phone,
                                 text: String(item.phone),
                                 font: UIFont.systemFont(ofSize: 14)) {
            contentStackView.addArrangedSubview(view)
        }
    }
}

extension MainTableViewCell {
    private struct Constants {
        let cornerRadius: CGFloat = 16
        let shadowOpacity: Float = 0.08
        let shadowRadius: CGFloat = 4
        let shadowOffset = CGSize(width: 0, height: 1)
        let cornerViewHorisontalOffset: CGFloat = 12
        let cornerViewVerticalOffset: CGFloat = 4
        let cornerViewOffset: CGFloat = 8
        let contentStackViewTopConstraint: CGFloat = 16
        let contentStackViewOffsetConstraint: CGFloat = 16
        let contentStackViewSpacing: CGFloat = 16
        let heightPlayerImageView: CGFloat = 100
        let widthPlayerImageView: CGFloat = 100
    }
}
