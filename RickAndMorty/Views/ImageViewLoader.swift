//
//  ImageViewLoader.swift
//  RickAndMorty
//
//  Created by Eugene St on 05.04.2020.
//  Copyright © 2020 Eugene St. All rights reserved.
//

import UIKit

// MARK: - Private properties
private let imageCache = NSCache<AnyObject, AnyObject>()

class ImageViewLoader: UIImageView {
  
  // MARK: - Public properties
  var imageURL: URL?
  let activityIndicator = UIActivityIndicatorView()
  
  // MARK: - Public methods
  func loadImageWithUrl(_ url: URL) {
    
    // Setup activityIndicator
    activityIndicator.color = .darkGray
    addSubview(activityIndicator)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    imageURL = url
    image = nil
    activityIndicator.startAnimating()
    
    // Retrieve image if already available in cache
    if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
      
      self.image = imageFromCache
      activityIndicator.stopAnimating()
      return
    }
    
    // If image is not available in cache retrieve it from url
    URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
      
      if error != nil {
        print(error as Any)
        DispatchQueue.main.async(execute: {
          self.activityIndicator.stopAnimating()
        })
        return
      }
      
      DispatchQueue.main.async(execute: {
        if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
          if self.imageURL == url {
            self.image = imageToCache
          }
          
          imageCache.setObject(imageToCache, forKey: url as AnyObject)
        }
        self.activityIndicator.stopAnimating()
      })
    }).resume()
  }
}
