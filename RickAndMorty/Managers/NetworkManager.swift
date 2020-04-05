//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Eugene St on 02.04.2020.
//  Copyright © 2020 Eugene St. All rights reserved.
//

import Foundation

class NetworkManager {
  
  static let shared = NetworkManager()
  
  private init() {}
  
  func fetchData(completion: @escaping ([Result]) -> Void) {
    
    var results: [Result] = []
    var strings: [String] = []
    let pagesNumber = 20
    
    for index in 1...pagesNumber {
      let urlString = "https://rickandmortyapi.com/api/character/?page=\(index)"
      strings.append(urlString)
    }
    
    strings.forEach { urlString in
      
      guard let url = URL(string: urlString) else { return }
      
      URLSession.shared.dataTask(with: url) { (data, _, error) in
        
        if let error = error { print(error); return }
        guard let data = data else { return }
        
        do {
          let character = try JSONDecoder().decode(Character.self, from: data)
          results.append(contentsOf: character.results)
          completion(results)
        } catch let jsonError {
          print(jsonError.localizedDescription)
        }
      }.resume()
    }
  }
}
