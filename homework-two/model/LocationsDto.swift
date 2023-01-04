//
//  LocationsDto.swift
//  homework-two
//
//  Created by Emre Muhammet Engin on 1.01.2023.
//

import Foundation

// MARK: - Location
struct LocationDto: Decodable {
    let info: Info?
    let results: [LocationResult]?
}



// MARK: - Result
struct LocationResult: Decodable {
    let id: Int?
    let name, type, dimension: String?
    let residents: [String]?
    let url: String?
    let created: String?
}
