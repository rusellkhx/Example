//
//  Team.swift
//  Example
//
//  Created by Rusell on 31.07.2022.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - TeamPlayers
struct Players: Codable {
    let copyright: String
    let roster: [Roster]
    let link: String
}

// MARK: - Roster
struct Roster: Codable {
    let person: Person
    let jerseyNumber: String
    let position: Position
}

// MARK: - Person
struct Person: Codable {
    let id: Int
    let fullName, link: String
}

// MARK: - Position
struct Position: Codable {
    let code, name: String
    let type: TypeEnum
    let abbreviation: String
}

enum TypeEnum: String, Codable {
    case defenseman = "Defenseman"
    case forward = "Forward"
    case goalie = "Goalie"
}
