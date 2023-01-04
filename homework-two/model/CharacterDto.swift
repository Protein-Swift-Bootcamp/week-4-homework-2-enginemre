//
//  Character.swift
//  homework-two
//
//  Created by Emre Muhammet Engin on 30.12.2022.
//

import Foundation
// MARK: - Character
struct Character: Decodable {
    let info: Info?
    let results: [Result]?
}

// MARK: - Info
struct Info: Decodable {
    let count, pages: Int?
    let next: String?
    let prev: String?
}

// MARK: - Result
struct Result: Decodable {
    let id: Int?
    let name, status, species, type: String?
    let gender: String?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

// MARK: - Location
struct Location: Decodable {
    let name: String?
    let url: String?
}
