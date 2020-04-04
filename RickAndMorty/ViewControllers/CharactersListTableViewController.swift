//
//  CharactersListTableViewController.swift
//  RickAndMorty
//
//  Created by Eugene St on 02.04.2020.
//  Copyright © 2020 Eugene St. All rights reserved.
//

import UIKit

class CharactersListTableViewController: UITableViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var sortLabelButton: UIBarButtonItem!
  
  // MARK: - Private properties
  private var character: Character?
  private var ascendingSorting = true
  
  // MARK: - UIViewController methods
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
    character?.results.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CustomCharacterCell
    let result = character?.results[indexPath.row]
    cell.configureCell(with: result)
    return cell
  }
  
  // MARK: - IBactions
  // Logic to sort items in asscending/descending order
  @IBAction func sortItems() {
    if ascendingSorting {
      character?.results.sort(by: >)
//      sortLabelButton.image = UIImage(systemName: "arrow.up")
      ascendingSorting.toggle()
    } else {
      character?.results.sort(by: <)
//      sortLabelButton.image = UIImage(systemName: "arrow.down")
      ascendingSorting.toggle()
    }
    tableView.reloadData()
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let detailsVC = segue.destination as! DetailsViewController
    guard let indexPath = tableView.indexPathForSelectedRow else { return }
    let result = character?.results[indexPath.row]
    detailsVC.character = result
  }
}
