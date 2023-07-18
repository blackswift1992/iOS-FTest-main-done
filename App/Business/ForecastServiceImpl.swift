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
    private var itemsSubject = CurrentValueSubject<ForecastItems, Never>(ForecastItems())

    var items: CurrentValueSubject<ForecastItems, Never> {
        return itemsSubject
    }

    private var bag = Set<AnyCancellable>()
    
    init() {
        GlobalContainer.defaultContainer.resolve(ForecastNetworkService.self)?.getForecast()
            .sink(receiveCompletion: { _ in }, receiveValue: {[weak self] value in
                var forecastItems = ForecastItems()
                
                value.forEach {
                    forecastItems.append(ForecastItem(day: $0.day, description: $0.description, chanceRain: $0.chanceRain))
                }
                
                self?.updateForecastItems(newItems: forecastItems)
            })
            .store(in: &bag)
    }
    
    func updateForecastItems(newItems: ForecastItems) {
        itemsSubject.send(newItems)
    }
}
