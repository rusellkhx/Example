//
//  MainPresenter.swift
//  Example
//
//  Created by Rusell on 28.07.2022.
//

import Foundation

// MARK: - Presenter

protocol MainPresenter: AnyObject {
    func didTriggerViewReadyEvent()
    func didSelectUserById(id: Int)
    func didTriggerRefreshData()
    func getTitle() -> String
}

// MARK: - PresenterImpl

final class MainPresenterImpl: MainPresenter {
    
    // MARK: - Private properties
    
    private weak var view: MainView?
    private let interactor: MainInteractor
    private let router: MainRouter
    private let constants = Constants()
    
    // MARK: - Lifecycle
    
    init(view: MainView, interactor: MainInteractor, router: MainRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - MainPresenter
    
    func didTriggerViewReadyEvent() {
        interactor.loadAndCheckData()
        interactor.subscribeOnUsers { [weak self] users in
            guard let self = self else { return }
            self.view?.set(users: users.map { UserItem(user: $0) })
            self.view?.reloadData()
        }
    }
    
    func didSelectUserById(id: Int) {
        guard let user = interactor.loadSelectedUserBy(id) else { return }
        router.showUserDetails(user)
    }

    func didTriggerRefreshData() {
        interactor.refreshData {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) { [weak self] in
                guard let self = self else { return }
                self.view?.hideLoadingIndicator()
            }
        }
    }
    
    func getTitle() -> String {
        return constants.title
    }
}

extension MainPresenterImpl {
    private struct Constants {
        let title = "User"
    }
}
