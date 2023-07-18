//
//  ListViewController.swift
//  App
//
//

import UIKit
import Combine
import GlobalUI

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
    }
}


//MARK: - UITableView Delegate/DataSource


extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getItems().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listCell = tableView.dequeueReusableCell(withIdentifier: "\(ListCell.self)", for: indexPath) as? ListCell else { return UITableViewCell() }

        let item = viewModel.getItems()[indexPath.row]
        listCell.textLabel?.text = "Day: \(item.day), description: \(item.description)"

        return listCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.goToDetailsView(itemIndex: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


//MARK: - TableViewCellSwiping


extension ListViewController {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction =  UIContextualAction(style: .destructive, title: "Delete") {
            [weak self] (deleteAction, button, handler) in
            self?.deleteItem(at: indexPath)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}


//MARK: - Private methods


private extension ListViewController {
    func deleteItem(at indexPath: IndexPath) {
        viewModel.removeItem(at: indexPath.row)
        
        tableView.performBatchUpdates {
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}


//MARK: - Setup methods


private extension ListViewController {
    func addSubviews() {
        view.addSubview(tableView)
    }

    func configure() {
        tableView.register(ListCell.self, forCellReuseIdentifier: "\(ListCell.self)")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = GlobalColor.backgroundColor
        self.title = viewModel.getTitle()
        tableView.rowHeight = 80
        
        viewModel.setItemsAdded() { [weak self] in
            self?.tableView.reloadData()
        }
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor .constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}
