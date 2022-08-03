//
//  DetailsInteractor.swift
//  Example
//
//  Created by Rusell on 02.08.2022.
//

import UIKit

protocol DetailsInteractor: AnyObject {
    func loadUser(id: Int) -> RealmUser?
    func openEmailClient(recipient: String)
    func callTo(subscriber: String)
    func openMap(coordinates: String)
}

final class DetailsInteractorImpl: DetailsInteractor {

    private let storageService: StorageService

    // MARK: - Lifecycle

    init(storageService: StorageService) {
        self.storageService = storageService
    }

    // MARK: - DetailsInteractor

    func loadUser(id: Int) -> RealmUser? {
        return storageService.loadUser(id: id)
    }
    
    func openEmailClient(recipient: String) {
        guard let url = URL(string: "mailto:\(recipient)") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func callTo(subscriber: String) {
        let number = subscriber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        guard let url = URL(string: "tel:\(number)") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func openMap(coordinates: String) {
        let path = "http://maps.apple.com/?q=" + coordinates
        guard let url = URL(string: path) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}


