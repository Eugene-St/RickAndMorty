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
  
  // MARK: - TableView DataSource
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    character.propertyNames().count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as! CustomDetailCell
    
    cell.configureCell(with: character, and: indexPath)
    
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
