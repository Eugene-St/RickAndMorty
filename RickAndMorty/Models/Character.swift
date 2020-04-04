//
//  Character.swift
//  RickAndMorty
//
//  Created by Eugene St on 02.04.2020.
//  Copyright © 2020 Eugene St. All rights reserved.
//

struct Character: Decodable {
  var results: [Result]
}

struct Result: Comparable, Decodable {
  
  static func == (lhs: Result, rhs: Result) -> Bool {
    lhs.name == rhs.name
  }
  
  static func < (lhs: Result, rhs: Result) -> Bool {
    lhs.name < rhs.name
  }
  
  let id: Int
  let name: String
  let status: String
  let species: String
  let gender: String
  let origin: Origin
  let location: Location
  let image: String

}

struct Origin: Decodable {
  let name: String
}

struct Location: Codable {
  let name: String
}
