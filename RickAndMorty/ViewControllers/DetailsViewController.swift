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
  @IBOutlet weak var characterImage: ImageViewLoader! {
    didSet {
      characterImage.layer.cornerRadius = characterImage.bounds.height / 2
    }
  }
  
  // MARK: Public properties
  var result: Result!
  
  // MARK: - UIViewController methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCharacterImage()
    title = result.name
  }
  
  // MARK: - TableView DataSource
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    result.propertyNames().count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as! DetailViewCell
    
    cell.configureCell(with: result, and: indexPath)
    
    return cell
  }
  
  // MARK: - Private methods
  private func setupCharacterImage() {
    
    guard let url = URL(string: result.image) else { return }
    characterImage.loadImageWithUrl(url)  }
}
