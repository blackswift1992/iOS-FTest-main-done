//
//  ListViewCoordinator.swift
//  App
//
//

import UIKit

class ListViewCoordinator {
    private weak var navigationController: UINavigationController?
    private weak var viewController: ListViewController?
}


//MARK: - Public methods


extension ListViewCoordinator {
    func start(window: UIWindow) {
        let viewModel = ListViewModel(coordinator: self)
        
        let viewController = ListViewController(viewModel: viewModel)
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigationController

        self.navigationController = navigationController
        self.viewController = viewController
    }
    
    func goToDetailsView(forecastItem: ForecastItem) {
        guard let navigationController = navigationController else { return }
        
        DetailViewCoordinator().start(navigationController: navigationController, forecastItem: forecastItem)
    }
}
