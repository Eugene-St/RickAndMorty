//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Eugene St on 02.04.2020.
//  Copyright © 2020 Eugene St. All rights reserved.
//

import UIKit

class NetworkManager {
  
  static let shared = NetworkManager()
  
  private let urlString = "https://rickandmortyapi.com/api/character"
  
  private init() {}
  
  func fetchData(with completion: @escaping (Character) -> Void) {
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, _, error) in
      if let error = error { print(error); return }
      guard let data = data else { return }
      
      do {
        let character = try JSONDecoder().decode(Character.self, from: data)
        completion(character)
      } catch let jsonError {
        print(jsonError.localizedDescription)
      }
    }.resume()
  }
}
