//
//  CharactersListTableViewController.swift
//  RickAndMorty
//
//  Created by Eugene St on 02.04.2020.
//  Copyright © 2020 Eugene St. All rights reserved.
//

import UIKit

class CharactersListTableViewController: UITableViewController {
  
  // MARK: - Private properties
  private var character: Character?

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
}
