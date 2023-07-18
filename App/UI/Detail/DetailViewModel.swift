//
//  DetailViewModel.swift
//  App
//
//

import Foundation

class DetailViewModel {
    private var forecastItemData = [String]()
    
    init(forecastItem: ForecastItem) {
        extractDataFrom(forecastItem: forecastItem)
    }
}


//MARK: - Public methods


extension DetailViewModel {
    func getForecastItemData() -> [String] {
        forecastItemData
    }
}


//MARK: - Private methods


private extension DetailViewModel {
    func extractDataFrom(forecastItem: ForecastItem) {
        forecastItemData.append("Day: \(forecastItem.day)")
        forecastItemData.append("Description: \(forecastItem.description)")
        forecastItemData.append("ChanceRain: \(forecastItem.chanceRain)")
    }
}
