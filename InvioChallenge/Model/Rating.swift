//
//  Rating.swift
//  InvioChallenge
//
//  Created by Mehmet Ali Kılıçlı on 24.11.2022.
//

import Foundation

struct Rating : Codable, Equatable {
    var source : String?
    var value : String?
    
    enum CodingKeys : String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
    
    
}
