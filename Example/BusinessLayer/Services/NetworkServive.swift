//
//  NetworkServive.swift
//  Example
//
//  Created by Rusell on 31.07.2022.
//

import UIKit
import Alamofire

typealias FetchUsersCompletion = (Result<[User]?>) -> Void

enum NetworkServiceError: Error {
    case badURL
}

protocol NetworkService: AnyObject {
    func fetchUsers(completion: @escaping FetchUsersCompletion)
}

final class NetworkServiceImpl: NetworkService {
    private let jsonUrl = "https://dummyjson.com/users"
    
    func fetchUsers(completion: @escaping FetchUsersCompletion) {
        guard let url = URL(string: jsonUrl) else {
            completion(.failure(NetworkServiceError.badURL))
            return
        }
        
        request(url).validate().responseJSON { dataResponse in
            switch dataResponse.result {
            case .success:
                let decoder = JSONDecoder()
                do {
                    if let data = dataResponse.data {
                        let users = try decoder.decode(UserModel.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(users.users))
                        }
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

