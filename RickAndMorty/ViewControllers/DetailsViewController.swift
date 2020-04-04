//
//  DetailsViewController.swift
//  RickAndMorty
//
//  Created by Eugene St on 02.04.2020.
//  Copyright © 2020 Eugene St. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDataSource {
  
  // MARK: - IBOutlets
  @IBOutlet weak var characterImage: UIImageView! {
    didSet {
      characterImage.layer.cornerRadius = characterImage.bounds.height / 2
    }
  }
  
  // MARK: Public properties
  var character: Result!
  
  // MARK: - UIViewContrroller methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCharacterImage()
    title = character.name
  }
  
  // MARK: - Table view data source
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    character.propertyNames().count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath)
    
    switch indexPath.row {
    case 0 : cell.textLabel?.text = "Name - \(character.name)"
    case 1:  cell.textLabel?.text = "Status - \(character.status)"
    case 2:  cell.textLabel?.text = "Species - \(character.species)"
    case 3:  cell.textLabel?.text = "Gender - \(character.gender)"
    case 4:  cell.textLabel?.text = "Origin - \(character.origin.name)"
    case 5:  cell.textLabel?.text = "Location - \(character.location.name)"
    default: cell.textLabel?.text = ""
    }
    
    /*
    switch character.propertyNames()[indexPath.row] {
    case "name" : cell.textLabel?.text = "Name - \(character.name)"
    case "status": cell.textLabel?.text = "Status - \(character.status)"
    case "species": cell.textLabel?.text = "Species - \(character.species)"
    case "gender": cell.textLabel?.text = "Species - \(character.gender)"
    case "origin": cell.textLabel?.text = "Origin - \(character.origin.name)"
    case "location": cell.textLabel?.text = "Location - \(character.location.name)"
    default: cell.textLabel?.text = ""
    }
    */
    
    return cell
  }
  
  // MARK: - Private methods
  private func setupCharacterImage() {
    DispatchQueue.global().async {
      let stringUrl = self.character.image
      guard let imageUrl = URL(string: stringUrl) else { return }
      guard let imageData = try? Data(contentsOf: imageUrl) else { return }
      DispatchQueue.main.async {
        self.characterImage.image = UIImage(data: imageData)
      }
    }
  }
}
