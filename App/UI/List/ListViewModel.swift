//
//  ListViewModel.swift
//  App
//
//

import Global
import GlobalUI
import Combine

class ListViewModel {
    var coordinator: ListViewCoordinator?
    @Inject var service: ForecastService
    private var bag = Set<AnyCancellable>()

    var items: [ForecastItem] = []
    
    var itemsAdded: (() -> Void)?

    var showDetail: ((ForecastItem) -> Void)?

    var title: String = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as! String

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
