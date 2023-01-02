//
//  Project.swift
//  RestAPICall
//
//  Created by Besh P.Yogi on 02.01.23.
//

import Foundation
struct Project: Codable, Identifiable{
    let id: Int
    let name: String
    let active: Bool
    let status: String
    /*
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case name = "name"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws{
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try valueContainer.decode(Int.self, forKey: CodingKeys.id)
        self.name = try valueContainer.decode(String.self, forKey: CodingKeys.name)
        self.status = try valueContainer.decode(String.self, forKey: CodingKeys.status)
    }*/
}

