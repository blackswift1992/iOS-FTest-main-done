//
//  ForecastServiceImpl.swift
//  App
//
//  Created by Олексій Мороз on 17.07.2023.
//

import Foundation
import Combine
import Global

class ForecastServiceImpl: ForecastService {
    @Inject var networkService: ForecastNetworkService
    private var itemsSubject = CurrentValueSubject<ForecastItems, Never>(ForecastItems())
    
    var items: CurrentValueSubject<ForecastItems, Never> { itemsSubject }
    
    private var bag = Set<AnyCancellable>()
    
    init() {
        networkService.getForecast()
            .sink(receiveCompletion: { _ in }, receiveValue: {[weak self] value in
                let forecastItems = value.map({ ForecastItem(day: $0.day, description: $0.description, chanceRain: $0.chanceRain) })
                
                self?.updateForecastItems(newItems: forecastItems)
            })
            .store(in: &bag)
    }
    
    func updateForecastItems(newItems: ForecastItems) {
        itemsSubject.send(newItems)
    }
}
