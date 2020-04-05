//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Eugene St on 02.04.2020.
//  Copyright © 2020 Eugene St. All rights reserved.
//
import UIKit

class CharacterCell: UITableViewCell {
  
  // MARK: - IBOutlets
  @IBOutlet weak var characterTextLabel: UILabel!
  @IBOutlet weak var imageLabel: ImageViewLoader! {
    didSet {
      imageLabel.layer.cornerRadius = imageLabel.bounds.height / 2
    }
  }
  
  // MARK: - Public methods
  func configureCell(with result: Result) {
    characterTextLabel.text = result.name
    guard let url = URL(string: result.image) else { return }
    imageLabel.loadImageWithUrl(url)
  }
}







