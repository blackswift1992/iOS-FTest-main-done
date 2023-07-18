//
//  DetailViewController.swift
//  App
//
//

import UIKit
import Combine
import GlobalUI

class DetailViewController: UIViewController {
    let contentView = DetailView.useConstraint
    
    private var viewModel: DetailViewModel
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
        // TODO: add content view as subview
        navigationController?.navigationBar.tintColor = .white
        title = "Details"
        view.layer.backgroundColor = GlobalColor.backgroundColor?.cgColor
        
        let subView = DetailView(frame: view.bounds)
        subView.addItems(viewModel.forecastItemData)
        view.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
        subView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
    }
}
