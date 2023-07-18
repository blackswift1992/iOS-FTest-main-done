//
//  ListViewCoordinator.swift
//  App
//
//

import UIKit

class ListViewCoordinator {
    weak var navigationController: UINavigationController?
    private weak var viewController: ListViewController?

    public func start(window: UIWindow) {
        let viewModel = ListViewModel(coordinator: self)
        
        let viewController = ListViewController(viewModel: viewModel)
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigationController

        self.navigationController = navigationController
        self.viewController = viewController
    }
    
    func goToDetailsView(forecastItem: ForecastItem) {
        guard let navigationController = navigationController else { return }
        
        let detailViewCoordinator = DetailViewCoordinator()
        detailViewCoordinator.start(navigationController: navigationController, forecastItem: forecastItem)
    }
}
