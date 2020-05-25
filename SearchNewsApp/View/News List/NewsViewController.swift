//
//  ViewController.swift
//  SearchNewsApp
//
//  Created by Дмитрий Бадер on 18.05.2020.
//  Copyright © 2020 Дмитрий Бадер. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
	
	weak var viewModel: NewsViewModel!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "News"
		
		setupTable()
		setupView()
		setupSearchBar()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		if let indexPath = tableView.indexPathForSelectedRow {
			tableView.deselectRow(at: indexPath, animated: true)
			tableView.reloadRows(at: [indexPath], with: .automatic)
		}
	}
	
	private let tableView: UITableView = {
		let table = UITableView()
		table.translatesAutoresizingMaskIntoConstraints = false
		return table
	}()
	
	private let searchController = UISearchController(searchResultsController: nil)
	
	private func setupTable() {
		tableView.delegate = self
		tableView.dataSource = self
		
		tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
		
		tableView.tableFooterView = UIView()
	}
	
	private func setupSearchBar() {
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Search news"
		searchController.searchBar.delegate = self
		navigationItem.searchController = searchController
	}
	
	private func setupView() {
		
		view.backgroundColor = .systemBackground
		
		view.addSubview(tableView)
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
}

//MARK: TableViewDataSource and Delegate
extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfRows()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = NewsTableViewCell()
		cell.viewModel = viewModel.cellViewModel(index: indexPath.row)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		SceneDelegate.shared.rootViewController.pushDetailsViewController(with: viewModel.detailsViewModel(index: indexPath.row))
	}
}

//MARK: Serach Bar
extension NewsViewController: UISearchBarDelegate {
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		viewModel.getNews(on: searchBar.text!) { isSuccessed in
			if isSuccessed {
				self.tableView.reloadData()
			} else {
				let errorAlert = UIAlertController(title: "Error", message: self.viewModel.getError(), preferredStyle: .alert)
				let okAction = UIAlertAction(title: "ok", style: .default)
				errorAlert.addAction(okAction)
				self.present(errorAlert, animated: true, completion: nil)
			}
		}
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		viewModel.cleanNews() {
			self.tableView.reloadData()
		}
	}
}

