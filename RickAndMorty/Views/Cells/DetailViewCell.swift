//
//  DetailViewCell.swift
//  RickAndMorty
//
//  Created by Eugene St on 04.04.2020.
//  Copyright © 2020 Eugene St. All rights reserved.
//

import UIKit

class DetailViewCell: UITableViewCell {
  
  // MARK: - IBOutlets
  @IBOutlet weak var characterLabel: UILabel!
  
  func configureCell(with result: Result, and indexPath: IndexPath) {
    let property = result.propertyNames()[indexPath.row]
    
    switch property {
    case "name"    : characterLabel?.text = "Name - \(result.name)"
    case "status"  : characterLabel?.text = "Status - \(result.status)"
    case "species" : characterLabel?.text = "Species - \(result.species)"
    case "gender"  : characterLabel?.text = "Gender - \(result.gender)"
    case "origin"  : characterLabel?.text = "Origin - \(result.origin.name)"
    case "location": characterLabel?.text = "Location - \(result.location.name)"
    default: characterLabel?.text = ""
    }
  }
}
