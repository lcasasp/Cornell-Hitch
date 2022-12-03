//
//  Rides.swift
//  Hackathon
//
//  Created by Josh Magazine on 12/1/22.
//

import Foundation
struct Rides : Codable {
    let hosting: [Ride]?
    let riding: [Ride]?
    enum CodingKeys: String, CodingKey {
        case hosting
        case riding
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(hosting, forKey: .hosting)
        try container.encode(riding, forKey: .riding)
       
        }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hosting = try values.decode([Ride].self, forKey: .hosting)
        riding = try values.decode([Ride].self, forKey: .riding)
        
}
}
