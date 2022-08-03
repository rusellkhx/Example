//
//  MainRouter.swift
//  Example
//
//  Created by Rusell on 28.07.2022.
//

import UIKit

// MARK: - Router

protocol MainRouter: AnyObject {
    func showUserDetails(_ user: RealmUser)
}

// MARK: - RouterImpl

final class MainRouterImpl: MainRouter {
    
    weak var viewController: UIViewController?
    
    func showUserDetails(_ user: RealmUser) {
        let vc = DetailsAssembly.createModule(user: user)
        viewController?.show(vc, sender: self)
    }
}
