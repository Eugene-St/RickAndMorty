//
//  CharactersListTableViewController.swift
//  RickAndMorty
//
//  Created by Eugene St on 02.04.2020.
//  Copyright © 2020 Eugene St. All rights reserved.
//

import UIKit

class CharactersListTableViewController: UITableViewController {
  
  // MARK: - IB Outlets
  @IBOutlet weak var sortLabel: UIBarButtonItem!
  
  
  // MARK: - Private properties
  private var character: Character?
  
  // MARK: - Public properties
  
  var ascendingSorting = true
  
  // MARK: - UIViewContrroller methods
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = 60
    
    NetworkManager.shared.fetchData { character in
      DispatchQueue.main.async {
        self.character = character
        self.tableView.reloadData()
      }
    }
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return character?.results.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CustomCharacterCell
    let result = character?.results[indexPath.row]
    cell.configureCell(with: result)
    return cell
  }
  
  // MARK: - IBactions
  
  // Logic to sort items in asscending/descending mode
  @IBAction func sortItems() {
    if ascendingSorting {
      character?.results.sort(by: >)
      sortLabel.image = UIImage(systemName: "arrow.up")
      ascendingSorting.toggle()
    } else {
      character?.results.sort(by: <)
      sortLabel.image = UIImage(systemName: "arrow.down")
      ascendingSorting.toggle()
    }
    tableView.reloadData()
  }
}
