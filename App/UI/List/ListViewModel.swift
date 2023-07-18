//
//  ListViewModel.swift
//  App
//
//

import Global
import GlobalUI
import Combine

class ListViewModel {
    private var coordinator: ListViewCoordinator?
    @Inject private var service: ForecastService
    
    private var bag = Set<AnyCancellable>()
    
    private var title: String = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as! String
    private var items: ForecastItems = []
    private var itemsAdded: (() -> Void)?
    
    init(coordinator: ListViewCoordinator?) {
        service.items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.items = $0
                self?.itemsAdded?()
            }
            .store(in: &bag)
        
        self.coordinator = coordinator
    }
}


//MARK: - Public methods

extension ListViewModel {
    func getTitle() -> String {
        title
    }
    
    func setItemsAdded(_ closure: (() -> Void)?) {
        itemsAdded = closure
    }
    
    func removeItem(at index: Int) {
        items.remove(at: index)
    }
    
    func getItems() -> ForecastItems {
       items
    }
    
    func goToDetailsView(itemIndex: Int) {
        coordinator?.goToDetailsView(forecastItem: items[itemIndex])
    }
}
