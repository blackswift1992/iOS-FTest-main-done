//
//  ListViewController.swift
//  App
//
//

import UIKit
import Combine
import GlobalUI
import SwipeCellKit

class ListViewController: UIViewController {
    private var viewModel: ListViewModel
    private let tableView = UITableView.useConstraint

    public init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configure()
        setupLayout()
        self.title = viewModel.title
        
        tableView.rowHeight = 80
        viewModel.itemsAdded = { [weak self] in
            self?.tableView.reloadData()
        }
    }

    private func addSubviews() {
        view.addSubview(tableView)
    }

    private func configure() {
        tableView.register(ListCell.self, forCellReuseIdentifier: "\(ListCell.self)")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = GlobalColor.backgroundColor
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor .constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(ListCell.self)", for: indexPath)
        
        if let swipeCell = cell as? SwipeTableViewCell {
            swipeCell.delegate = self
        }
        
        guard let listCell = cell as? ListCell else { return UITableViewCell() }
        
        let item = viewModel.items[indexPath.row]
        
        listCell.textLabel?.text = "Day: \(item.day), description: \(item.description)"

        return listCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.coordinator?.goToDetailsView(forecastItem: viewModel.items[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


//MARK: - SwipeTableViewCellDelegate


extension ListViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [weak self] action, indexPath in
            self?.viewModel.items.remove(at: indexPath.row)
        }

        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
}
