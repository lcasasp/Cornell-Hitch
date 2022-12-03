//
//  User.swift
//  Hackathon
//
//  Created by Josh Magazine on 11/30/22.
//

import Foundation

struct User: Codable{
    let id: Int?
    let email: String?
    let name: String?
    let rides: Rides?
    let messages: [Message]?


    
     enum CodingKeys: String, CodingKey {
     
        case id
        case email
        case name
        case rides
        case messages
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(email, forKey: .email)
        try container.encode(name, forKey: .name)
        try container.encode(rides, forKey: .rides)
        try container.encode(messages, forKey: .messages)
        }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        email = try values.decode(String.self, forKey: .email)
        name = try values.decode(String.self, forKey: .name)
        rides = try values.decode(Rides.self, forKey: .name)
        messages = try values.decode([Message].self, forKey: .name)
        
        
    }
}



