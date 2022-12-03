//
//  Message.swift
//  Hackathon
//
//  Created by Josh Magazine on 11/23/22.
//

import Foundation

struct Message: Codable {
    let id: Int?
    let time: String?
    let text: String?
    let sender: User_Serialized?
    let recipient: User_Serialized?

    private enum CodingKeys: String, CodingKey {
        case id
        case time
        case text
        case sender
        case recipient
    }
    
    init(id:Int, time: String, text: String, sender:User_Serialized, recipient: User_Serialized){
        self.id = id
        self.time = time
        self.text = text
        self.sender = sender
        self.recipient = recipient
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(time, forKey: .time)
        try container.encode(text, forKey: .text)
        try container.encode(sender, forKey: .sender)
        try container.encode(recipient, forKey: .recipient)
        }
    
        init(from decoder:Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decode(Int.self, forKey: .id)
            time = try values.decode(String.self, forKey: .time)
            text = try values.decode(String.self, forKey: .text)
            sender = try values.decode(User_Serialized.self, forKey: .sender)
            recipient = try values.decode(User_Serialized.self, forKey: .recipient)
    }
}
