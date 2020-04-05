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
  private var results: [Result]?
  private var ascendingSorting = true
  private let searchController = UISearchController(searchResultsController: nil)
  private var filteredChracter: [Result] = []
  private var searchBarIsEmpty: Bool {
    guard let text = searchController.searchBar.text else { return false }
    return text.isEmpty
  }
  private var isFiltering: Bool {
    return searchController.isActive && !searchBarIsEmpty
  }
  
  // MARK: - UIViewController methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSearchController()
    setupNavigationBar()
    tableView.rowHeight = 60
    
    NetworkManager.shared.fetchData { results in
      DispatchQueue.main.async {
        self.results = results
        self.tableView.reloadData()
      }
    }
  }
  // MARK: - TableView DataSource
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    isFiltering ? filteredChracter.count : results?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CharacterCell
    if let result = isFiltering ? filteredChracter[indexPath.row] : results?[indexPath.row] {
      cell.configureCell(with: result)
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  // MARK: - IBactions
  /// Sort items in asscending/descending order
  @IBAction func sortItems() {
    if ascendingSorting {
      results?.sort(by: >)
      ascendingSorting.toggle()
    } else {
      results?.sort(by: <)
      ascendingSorting.toggle()
    }
    tableView.reloadData()
  }
  
  // MARK: - Private methods
  private func setupSearchController() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search"
    searchController.searchBar.barTintColor = .black
    navigationItem.searchController = searchController
    definesPresentationContext = true
    
    if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
      textField.font = UIFont.boldSystemFont(ofSize: 17)
      textField.textColor = .black
    }
  }
  
  private func setupNavigationBar() {
    
    navigationController?.navigationBar.prefersLargeTitles = true
    
    // Navigation bar appearance
    if #available(iOS 13.0, *) {
      let navBarAppearance = UINavigationBarAppearance()
      navBarAppearance.configureWithOpaqueBackground()
      navigationController?.navigationBar.standardAppearance = navBarAppearance
      navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let indexPath = tableView.indexPathForSelectedRow else { return }
    let result = isFiltering ? filteredChracter[indexPath.row] : results?[indexPath.row]
    let detailsVC = segue.destination as! DetailsViewController
    detailsVC.result = result
  }
  
}

// MARK: - UISearchResultsUpdating
extension CharactersListTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    filterContentForSearchText(searchController.searchBar.text!)
  }
  
  private func filterContentForSearchText(_ searchText: String) {
    filteredChracter = results?.filter { chracter in chracter.name.lowercased().contains(searchText.lowercased())
      } ?? []
    
    tableView.reloadData()
  }
}
