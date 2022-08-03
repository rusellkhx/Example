//
//  Photo.swift
//  Example
//
//  Created by Rusell on 03.08.2022.
//

import UIKit

protocol PhotoViewProtocol: AnyObject {
    func configure(image: UIImage?, name: String)
}

final class PhotoView: UIView {
    
    // MARK: - Private properties
    
    private let constants = Constants()
    
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
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: 24)
        nameLabel.textColor = .rbMainTexts
        return nameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        contentStackView.addArrangedSubview(userImageView)
        contentStackView.addArrangedSubview(nameLabel)
    }
}

extension PhotoView: PhotoViewProtocol {
    func configure(image: UIImage?, name: String) {
        if let image = image {
            userImageView.image = image
        }
        nameLabel.text = name
    }
}

extension PhotoView {
    private struct Constants {
        let contentStackViewSpacing: CGFloat = 16
    }
}
