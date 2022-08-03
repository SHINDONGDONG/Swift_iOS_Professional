//
//  AccountSummaryViewController+Networking.swift
//  Swift_Benkey
//
//  Created by 申民鐡 on 2022/08/04.
//

import Foundation
import UIKit

//Error 만들어놓고.
enum NetworkError: Error {
    case serverError
    case decodingError
}

//Profile의 ViewModel을 만듬.
struct Profile: Codable {
    let id: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

//AccountSummaryViewController에 장착해준다 
extension AccountSummaryViewController {
    func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile,NetworkError>) -> Void) {
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.serverError))
                return
            }
            
            do {
                let profile = try JSONDecoder().decode(Profile.self, from: data)
                completion(.success(profile))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
