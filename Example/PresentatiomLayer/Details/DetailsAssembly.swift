//
//  DetailsAssembly.swift
//  Example
//
//  Created by Rusell on 31.07.2022.
//

final class DetailsAssembly {
    static func createModule(user: RealmUser) -> DetailsViewController {
        let view = DetailsViewController()
        let interactor = DetailsInteractorImpl(storageService: StorageServiceImpl())
        let router = DetailsRouterImpl()
        let presenter = DetailsPresenterImpl(view: view, interactor: interactor, router: router, user: user)

        view.presenter = presenter
        router.viewController = view

        return view
    }
}
