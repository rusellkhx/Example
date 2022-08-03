//
//  CacheUser.swift
//  Example
//
//  Created by Rusell on 28.07.2022.
//

import Foundation
import RealmSwift

class RealmUser: Object {
    @objc dynamic var id = Int()
    @objc dynamic var name = String()
    @objc dynamic var firstName = String()
    @objc dynamic var lastName = String()
    @objc dynamic var maidenName = String()
    @objc dynamic var age = Int()
    @objc dynamic var gender = String()
    @objc dynamic var email = String()
    @objc dynamic var phone = String()
    @objc dynamic var username = String()
    @objc dynamic var password = String()
    @objc dynamic var birthDate = String()
    @objc dynamic var image = String()
    @objc dynamic var bloodGroup = String()
    @objc dynamic var height = Int()
    @objc dynamic var weight = Double()
    @objc dynamic var eyeColorString = String()
    var eyeColor: EyeColor {
        return EyeColor(rawValue: eyeColorString) ?? EyeColor.brown
    }
    @objc dynamic var domain = String()
    @objc dynamic var ip = String()
    @objc dynamic var adressUser: RealmAddressPlace?
    @objc dynamic private var macAddress = String()
    @objc dynamic var university = String()
    @objc dynamic var bank: RealmBank?
    @objc dynamic var adressCompany: RealmAdressCompany?
    @objc dynamic var ein = String()
    @objc dynamic var ssn = String()
    @objc dynamic var userAgent = String()
    
    override static func primaryKey() -> String? {
        return #keyPath(RealmUser.id)
    }
 
    convenience init(user: User) {
        self.init()
        
        self.id = user.id
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.name = user.firstName + " " + user.lastName
        self.maidenName = user.maidenName
        self.age = user.age
        self.gender = user.gender.rawValue
        self.email = user.email
        self.phone = user.phone
        self.username = user.username
        self.password = user.password
        self.birthDate = user.birthDate
        self.image = user.image
        self.bloodGroup = user.bloodGroup
        self.height = user.height
        self.weight = user.weight
        self.eyeColorString = user.eyeColor.rawValue
        self.domain = user.domain
        self.ip = user.ip
        self.adressUser = RealmAddressPlace(address: user.address.address,
                                            city: user.address.city ?? "",
                                            latitude: user.address.coordinates.lat,
                                            longitude: user.address.coordinates.lng,
                                            postalCode: user.address.postalCode,
                                            state: user.address.state
        )
        self.macAddress = user.macAddress
        self.university = user.university
        self.bank = RealmBank(cardExpire: user.bank.cardExpire,
                              cardNumber: user.bank.cardNumber,
                              cardType: user.bank.cardType,
                              currency: user.bank.currency,
                              iban: user.bank.iban
        )
        self.adressCompany = RealmAdressCompany(address: RealmAddressPlace(address: user.address.address,
                                                                           city: user.address.city ?? "",
                                                                           latitude: user.address.coordinates.lat,
                                                                           longitude: user.address.coordinates.lng,
                                                                           postalCode: user.address.postalCode,
                                                                           state: user.address.state
                                                                          ),
                                                department: user.company.department,
                                                name: user.company.name,
                                                title: user.company.title
        )
        self.ein = user.ein
        self.ssn = user.ssn
        self.userAgent = user.userAgent
    }
}

class SaveDate: Object {
    @objc dynamic var dateTime = Date()
}

class RealmAddressPlace: EmbeddedObject {
    @objc dynamic var address = String()
    @objc dynamic var city = String()
    @objc dynamic var latitude = Double()
    @objc dynamic var longitude = Double()
    var coordinates: String {
        return "\(latitude),\(longitude)"
    }
    @objc dynamic var postalCode = String()
    @objc dynamic var state = String()
    
    override init() {}
    
    required init(address: String, city: String, latitude: Double, longitude: Double, postalCode: String, state: String) {
        self.address = address
        self.city = city
        self.latitude = latitude
        self.longitude = longitude
        self.postalCode = postalCode
        self.state = state
    }
}

class RealmAdressCompany: EmbeddedObject {
    @objc dynamic var address: RealmAddressPlace?
    @objc dynamic var department = String()
    @objc dynamic var name = String()
    @objc dynamic var title = String()
    
    override init() {}
    
    required init(address: RealmAddressPlace, department: String, name: String, title: String) {
        self.address = address
        self.department = department
        self.name = name
        self.title = title
    }
}

class RealmBank: EmbeddedObject {
    @objc dynamic var cardExpire = String()
    @objc dynamic var cardNumber = String()
    @objc dynamic var cardType = String()
    @objc dynamic var currency = String()
    @objc dynamic var iban = String()
    
    override init() {}
    
    required init(cardExpire: String, cardNumber: String, cardType: String, currency: String, iban: String) {
        self.cardExpire = cardExpire
        self.cardNumber = cardNumber
        self.cardType = cardType
        self.currency = currency
        self.iban = iban
    }
}
