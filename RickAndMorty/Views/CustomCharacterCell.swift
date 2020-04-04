//
//  CustomCharacterCell.swift
//  RickAndMorty
//
//  Created by Eugene St on 02.04.2020.
//  Copyright © 2020 Eugene St. All rights reserved.
//

import UIKit

class CustomCharacterCell: UITableViewCell {
  
  @IBOutlet weak var characterTextLabel: UILabel!
  @IBOutlet weak var imageLabel: UIImageView! {
    didSet {
      imageLabel.contentMode = .scaleAspectFit
      imageLabel.clipsToBounds = true
      imageLabel.layer.cornerRadius = imageLabel.bounds.height / 2
      imageLabel.backgroundColor = .black
    }
  }
  
  func configureCell(with result: Result?) {
    guard let textLabel = result?.name else { return }
    characterTextLabel.text = textLabel
    
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
