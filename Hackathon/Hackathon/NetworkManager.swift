//
//  NetworkManager.swift
//  Hackathon
//
//  Created by Josh Magazine on 11/26/22.
//

import Foundation
import Alamofire
import SwiftUI



class NetworkManager {
    static let host = "http://35.194.68.103/"
    
    static let  json  = [
        "users" :     [
                    [
                "email" : "bj263@cornell.edu",
                "id" : 1,
                "messages" :             [
                    "recipient" :                 [
                    ],
                    "sender" :                 [
                    ],
                ],
                "name" : "Borjan Javonov",
                "rides" :             [
                    "hosting" :                 [
                    ],
                    "riding" :                 [
                    ],
                ],
            ]
    ]
        ]
    
    static func createRide(hostuser_id: Int, date: String, destination: String, capacity: Int) {
        let endpoint = "\(host)/api/users/" + String(hostuser_id) + "/ride/"
        
        let parameters: Parameters = [
            "date" : date,
            "destination" : destination,
            "capacity" : capacity,
        ]
        
        AF.request(endpoint, method: .post, parameters: parameters).validate().responseJSON { response in
            // handle response here
            switch response.result {
                
            case let .success(data):
                print(data)
                // If the response is a failure, print a description of the error
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getUsers(completion: @escaping (Response) -> Void) {
        let endpoint = "\(host)/api/users/"
        
        AF.request(endpoint, method: .get).validate().responseData{ response in
            // handle response here
            switch response.result {
                
            case  let .success(data):
                print(data)
                 
                let jsonDecoder = JSONDecoder()
                if let decoded = try? jsonDecoder.decode(Response.self, from: data){
                    print(decoded)
                    completion(decoded)
                }
                else{
                    print("Failed to decode createPost")
                }
            
                    
                
                // If the response is a failure, print a description of the error
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//    func getDms(){
//        NetworkManager.getUsers()
//           return user
//            
//        }
//    }
    
    static func createUser(email: String, name: String) {
        let endpoint = "\(host)/api/users/"
        
        let params: Parameters = [
            "email": email,
            "name": name
        ]
        
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseJSON{ response in
            // handle response here
        
            switch response.result {
                
            case .success(let data):
                print("the type of decoded is \(type(of: data))")
                print(data)

//                let jsonDecoder = JSONDecoder()
//                if let decoded = try? jsonDecoder.decode(Response.self, from: data) {
//                    print(decoded)
//                }else{
//                    print("nope")
//                }
                
                
                // print(decoded?.users[0].name)
            
                    
                
                // If the response is a failure, print a description of the error
            case .failure(let error):
                print("bruh")
                print(error.localizedDescription)
            }
        }
    }
    
    static func deleteUser(hostuser_id: String, ride: Ride) {
        let endpoint = "\(host)/api/users/\(hostuser_id)"
        
        
        AF.request(endpoint, method: .delete).validate().responseJSON { response in
            // handle response here
            switch response.result {
                
            case let .success(data):
                print(data)
                // If the response is a failure, print a description of the error
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func sendMessage(sender_id: Int, recipient_id: Int, text: String){
        let endpoint = "\(host)/api/users/\(String(sender_id))/messages/\(String(recipient_id))/"
        
        let parameters: Parameters = [
            "text": text
        ]
        
        AF.request(endpoint, method: .post, parameters: parameters).validate().responseJSON { response in
            // handle response here
            switch response.result {
                
            case let .success(data):
                print(data)
                // If the response is a failure, print a description of the error
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getRides(ride_id: Int)
    {
        let endpoint = "\(host)/api/rides/\(ride_id)/"
        AF.request(endpoint, method: .get).validate().responseJSON { response in
            // handle response here
            switch response.result {
                
            case let .success(data):
                print(data)
                // If the response is a failure, print a description of the error
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getMessage(message_id: Int)
    {
        let endpoint = "\(host)/api/rides/\(message_id)/"
        AF.request(endpoint, method: .get).validate().responseJSON { response in
            // handle response here
            switch response.result {
                
            case let .success(data):
                print(data)
                // If the response is a failure, print a description of the error
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func assignNewRider(ridernew_user_id: Int)
    {
        let endpoint = "\(host)/api/users/\(ridernew_user_id)/ride"
        
        let params : Parameters = [
            "ride_id": 2
        ]
        
        AF.request(endpoint, method: .post, parameters: params).validate().responseJSON { response in
            // handle response here
            switch response.result {
                
            case let .success(data):
                print(data)
                // If the response is a failure, print a description of the error
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    static func login(){
        let endpoint = "\(host)/login/"
        
        AF.request(endpoint, method: .get).validate().responseJSON { response in
            // handle response here
            switch response.result {
                
            case let .success(data):
                print(data)
                // If the response is a failure, print a description of the error
            case .failure(let error):
                print("yikes")
                print(error.localizedDescription)
            }
        }
    }
    
    static func logout(){
        let endpoint = "\(host)/logout/"
        
        AF.request(endpoint, method: .post).validate().responseJSON { response in
            // handle response here
            switch response.result {
                
            case let .success(data):
                print(data)
                // If the response is a failure, print a description of the error
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func loadMessages(sender_id: Int)
    {
        let endpoint = "\(host)/api/users/\(sender_id)/"
        AF.request(endpoint, method: .post).validate().responseJSON { response in
            // handle response here
            switch response.result {
                
            case let .success(data):
                print(data)
                
                // If the response is a failure, print a description of the error
            case .failure(let error):
                print(error.localizedDescription)
            }
        
        }
    }
    
    
}
