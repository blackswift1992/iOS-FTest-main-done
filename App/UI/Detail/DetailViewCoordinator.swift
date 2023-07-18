//
//  DetailViewCoordinator.swift
//  App
//
//

import UIKit

class DetailViewCoordinator {
    private weak var navigationController: UINavigationController?
    private weak var viewController: DetailViewController?
}


//MARK: - Public methods


extension DetailViewCoordinator {
    func start(navigationController: UINavigationController, forecastItem: ForecastItem) {
        let viewModel = DetailViewModel(forecastItem: forecastItem)
        let viewController = DetailViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)

        self.navigationController = navigationController
        self.viewController = viewController
    }
}
