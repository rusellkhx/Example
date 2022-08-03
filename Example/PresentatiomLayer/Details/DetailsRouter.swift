//
//  DetailsRouter.swift
//  Example
//
//  Created by Rusell on 02.08.2022.
//

import UIKit

protocol DetailsRouter: AnyObject {
    func showUserDetails(_ user: RealmUser)
}

// MARK: - DetailsRouterImpl

final class DetailsRouterImpl: DetailsRouter {
    weak var viewController: UIViewController?

    func showUserDetails(_ user: RealmUser) {
        print("Next screen soon")
    }
}
