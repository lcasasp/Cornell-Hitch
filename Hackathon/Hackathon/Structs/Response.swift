//
//  Response.swift
//  Hackathon
//
//  Created by Josh Magazine on 11/30/22.
//

import Foundation

struct Response: Codable{
    var users: [User]
    private enum CodingKeys: String, CodingKey {
        case users
    }
    
    var description: String {
        return "\(users)"
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(users,forKey: .users)
    }
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        users = try values.decode([User].self, forKey: .users)
    }
}

