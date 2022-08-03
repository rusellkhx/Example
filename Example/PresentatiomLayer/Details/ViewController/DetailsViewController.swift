//
//  DetailsViewController.swift
//  Example
//
//  Created by Rusell on 02.08.2022.
//

import UIKit

protocol DetailsView: AnyObject {
    var presenter: DetailsPresenter? { get set }
    func reloadData(navigationItemTitle: String, sections: [UserDetailsSection])
}

final class DetailsViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: DetailsPresenter?
    
    // MARK: - Private properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.separatorInset = .zero
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.register(CellClass: DetailTableViewCell.self)
        
        return tableView
    }()
    
    private let uerImage = PhotoView()
    
    private var sections: [UserDetailsSection]?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presenter?.didTriggerViewDidLoad()
    }

    // MARK: - Private functions
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true

        configureTableView()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections?[section].title
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections?[section].items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = sections?[indexPath.section].items[indexPath.row] else {
            fatalError("Cell not found")
        }
        return tableView.configureCell(for: item, indexPath: indexPath)
    }
}

// MARK: - UITableViewDelegate

extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = sections?[indexPath.section].items[indexPath.row]
        guard let item = item as? DetailsItem else { return }
        
        item.didSeletectItem?()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = AnimationFactory.makeMoveUpWithFade(rowHeight: cell.frame.height,
                                                            duration: 0.5,
                                                            delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
}

// MARK: - DetailsView

extension DetailsViewController: DetailsView {
    func reloadData(navigationItemTitle: String, sections: [UserDetailsSection]) {
        title = navigationItemTitle
        self.sections = sections
        tableView.reloadData()
    }
}
