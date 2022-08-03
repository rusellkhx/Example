//
//  MainAssembly.swift
//  Example
//
//  Created by Rusell on 28.07.2022.
//

import UIKit

final class MainAssembly {
    static func createModule() -> UIViewController {
        let view = MainViewController()
        let interactor = MainInteractorImpl(networkService: NetworkServiceImpl(), storageService: StorageServiceImpl())
        let router = MainRouterImpl()
        let presenter = MainPresenterImpl(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
}
