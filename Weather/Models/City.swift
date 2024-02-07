//  City.swift
//
//  Created by Albi GRAINCA and Batuhan GOKER
//

import Foundation


struct City : Identifiable, Codable {
    var id: Int
    var name: String
    var latitude: Double
    var longitude: Double
}

struct SearchResults: Codable {
    let results: [City]
}
