//
//  NetworkManager.swift
//  Hackathon
//
//  Created by Josh Magazine on 11/26/22.
//

import Foundation
class NetworkManager {
    static let host = "https://temporary.com"
}

//static func getAllPosts(completion: @escaping ([Post]) -> Void) {
//    let endpoint = "\(host)/posts/all/"
//    AF.request(endpoint, method: .get).validate().responseData { response in
//        switch response.result {
//        case .success(let data):
//            let jsonDecoder = JSONDecoder()
//                jsonDecoder.dateDecodingStrategy = .iso8601
//            if let userResponse = try? jsonDecoder.decode([Post].self, from: data) {
//                completion(userResponse)
//            } else {
//                print("Failed to decode getAllPosts")
//            }
//        case .failure(let error):
//            print(error.localizedDescription)
//        }
//    }
//}
