//
//  MainViewController.swift
//  Example
//
//  Created by Rusell on 28.07.2022.
//

import UIKit

protocol MainView: AnyObject {
    var presenter: MainPresenter? { get set }
    
    func reloadData()
    func set(users: [UserItem])
    func hideLoadingIndicator()
}

// MARK: - ViewImpl

final class MainViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: MainPresenter?

    // MARK: - Private properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CellClass: MainTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.separatorInset = .zero
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset.top = constants.tableViewTopOffset
        tableView.backgroundColor = .clear
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        return tableView
    }()
    
    private let refreshControl = UIRefreshControl()
    private var users: [UserItem]?
    private let constants = Constants()

    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presenter?.didTriggerViewReadyEvent()
    }
    
    // MARK: - Private functions
    
    private func setupUI() {
        navigationItem.title = presenter?.getTitle()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }

    @objc private func refresh() {
        presenter?.didTriggerRefreshData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(MainTableViewCell.self)
        if let users = users {
            cell.configure(with: users[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = AnimationFactory.makeSlideIn(duration: 0.5, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users?[indexPath.row]
       
        guard let id = user?.id else { return }
        
        presenter?.didSelectUserById(id: id)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - MainView

extension MainViewController: MainView {
    func reloadData() {
        tableView.reloadData()
    }
    
    func hideLoadingIndicator() {
        refreshControl.endRefreshing()
    }
    
    func set(users: [UserItem]) {
        self.users = users
        reloadData()
    }
}

extension MainViewController {
    private struct Constants {
        let tableViewTopOffset: CGFloat = 24
    }
}
