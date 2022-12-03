//
//  User_Serialized.swift
//  Hackathon
//
//  Created by Josh Magazine on 11/30/22.
//

import Foundation

struct User_Serialized: Codable{
    let id: Int?
    let email: String?
    let name: String?
    private enum CodingKeys: String, CodingKey {
        case id
        case email
        case name
        
    }
    init(id: Int, email: String, name: String) {
        self.id = id
        self.email = email
        self.name = name
        }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(email, forKey: .email)
        try container.encode(name, forKey: .name)
        }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        email = try values.decode(String.self, forKey: .email)
        name = try values.decode(String.self, forKey: .name)
        
}
}
