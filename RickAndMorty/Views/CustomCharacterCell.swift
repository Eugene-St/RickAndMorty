//
//  CustomCharacterCell.swift
//  RickAndMorty
//
//  Created by Eugene St on 02.04.2020.
//  Copyright © 2020 Eugene St. All rights reserved.
//
import UIKit

class CustomCharacterCell: UITableViewCell {
  
  // MARK: - IBOutlets
  @IBOutlet weak var characterTextLabel: UILabel!
  @IBOutlet weak var imageLabel: UIImageView! {
    didSet {
      imageLabel.layer.cornerRadius = imageLabel.bounds.height / 2
    }
  }
  
  // MARK: - Public methods
  func configureCell(with result: Result?) {
    characterTextLabel.text = result?.name
    self.imageLabel.image = #imageLiteral(resourceName: "defaultImage")
    
    DispatchQueue.global().async {
      guard let stringURL = result?.image else { return }
      guard let imageURL = URL(string: stringURL) else { return }
      guard let imageData = try? Data(contentsOf: imageURL) else { return }
      DispatchQueue.main.async {
        self.imageLabel.image = UIImage(data: imageData)
      }
    }
  }
}
