//
//  DetailsPresenter.swift
//  Example
//
//  Created by Rusell on 02.08.2022.
//

protocol DetailsPresenter: AnyObject {
    func didTriggerViewDidLoad()
}

final class DetailsPresenterImpl {
    private weak var view: DetailsView?
    private let interactor: DetailsInteractor
    private let router: DetailsRouter
    private let user: RealmUser
    private var sections: [UserDetailsSection] = []

    // MARK: - Lifecycle

    init(view: DetailsView, interactor: DetailsInteractor, router: DetailsRouter, user: RealmUser) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.user = user
    }

    
    // MARK: - Private functions

    private func callPhone(number: String?) {
        guard let number = number else { return }
        interactor.callTo(subscriber: number)
    }

    private func send(email: String?) {
        guard let email = email else { return }
        interactor.openEmailClient(recipient: email)
    }

    private func showMap(coordinates: String?) {
        guard let coordinates = coordinates else { return }
        interactor.openMap(coordinates: coordinates)
    }

    private func showUserDetailsInfo(_ item: TableViewItem) {
        guard let item = item as? UserItem, let user = interactor.loadUser(id: item.id) else {
            return
        }
        router.showUserDetails(user)
    }
}

// MARK: - DetailsPresenter

extension DetailsPresenterImpl: DetailsPresenter{
    func didTriggerViewDidLoad() {

        let infoItems: [TableViewItem] = [
            DetailsItem(title: FieldsConstants.age,
                        textType: .plain(String(user.age))),
            DetailsItem(title: FieldsConstants.gender,
                        textType: .plain(String(user.gender))),
            DetailsItem(title: FieldsConstants.bloodGroup,
                        textType: .plain(user.bloodGroup)),
            DetailsItem(title: FieldsConstants.height,
                        textType: .plain(String(user.height))),
            DetailsItem(title: FieldsConstants.weight,
                        textType: .plain(String(user.weight))),
            DetailsItem(title: FieldsConstants.phone,
                        textType: .plain(user.phone),
                        isAction: true,
                        didSeletectItem: { [weak self] in
                            guard let self = self else { return }
                            self.callPhone(number: self.user.phone)
                        }),
            DetailsItem(title: FieldsConstants.email,
                        textType: .plain(user.email),
                        isAction: true,
                        didSeletectItem: { [weak self] in
                            guard let self = self else { return }
                            self.send(email: self.user.email)
                        }),
            DetailsItem(title: FieldsConstants.adress,
                        textType: .plain(user.adressUser?.address ?? "")),
            DetailsItem(title: FieldsConstants.coodinates,
                        textType: .plain(user.adressUser?.coordinates ?? ""),
                        isAction: true,
                        didSeletectItem: { [weak self] in
                            guard let self = self else { return }
                            self.showMap(coordinates: self.user.adressUser?.coordinates)
                        }),
        ]

        let infoSection = UserDetailsSection(title: nil, items: infoItems)

        sections = [infoSection]
        view?.reloadData(navigationItemTitle: user.name, sections: sections)
    }
}
