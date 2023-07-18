//
//  DetailViewController.swift
//  App
//
//

import UIKit
import Combine
import GlobalUI

class DetailViewController: UIViewController {
    private var viewModel: DetailViewModel
    
    let contentView = DetailView.useConstraint
    private let tableView = UITableView.useConstraint

    public init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        navigationController?.navigationBar.tintColor = .white
        title = "Details"
        view.layer.backgroundColor = GlobalColor.backgroundColor?.cgColor
        
        contentView.frame = view.bounds
        contentView.addItems(viewModel.forecastItemData)
        view.addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
    }
}
