//
//  Ride.swift
//  Hackathon
//
//  Created by Josh Magazine on 11/28/22.
//

import Foundation
struct Ride : Codable {
    let id: Int?
    let date: String?
    let destination: String?
    let host: User_Serialized?
    let riders: [User_Serialized]?
    let capacity: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case date
        case destination
        case host
        case riders
        case capacity
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id,forKey: .id)
        try container.encode(date, forKey: .date)
        try container.encode(destination, forKey: .destination)
        try container.encode(host, forKey: .host)
        try container.encode(riders, forKey: .riders)
        }
    
            init(from decoder:Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                id = try values.decode(Int.self, forKey: .id)
                date = try values.decode(String.self, forKey: .date)
                destination = try values.decode(String.self, forKey: .destination)
                host = try values.decode(User_Serialized.self, forKey: .host)
                riders = try values.decode([User_Serialized].self, forKey: .riders)
                capacity = try values.decode(Int.self, forKey: .capacity)
        }

}
