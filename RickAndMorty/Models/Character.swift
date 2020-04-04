//
//  Character.swift
//  RickAndMorty
//
//  Created by Eugene St on 02.04.2020.
//  Copyright © 2020 Eugene St. All rights reserved.
//

protocol PropertyNames {
    func propertyNames() -> [String]
}

struct Character: Decodable {
  var results: [Result]
}

struct Result: Comparable, Decodable, PropertyNames {
  
  static func == (lhs: Result, rhs: Result) -> Bool {
    lhs.name == rhs.name
  }
  
  static func < (lhs: Result, rhs: Result) -> Bool {
    lhs.name < rhs.name
  }
  
//  let id: Int
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

struct Location: Decodable {
  let name: String
}

extension PropertyNames
{
    func propertyNames() -> [String] {
      Mirror(reflecting: self).children.compactMap { $0.label }
    }
}
