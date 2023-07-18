//
//  DetailViewModel.swift
//  App
//
//

import Foundation

class DetailViewModel {
    var forecastItemData = [String]()
    
    init(forecastItem: ForecastItem) {
        extractItemsFrom(forecastItem: forecastItem)
    }
    
    private func extractItemsFrom(forecastItem: ForecastItem) {
        forecastItemData.append("Day: \(forecastItem.day)")
        forecastItemData.append("Description: \(forecastItem.description)")
        forecastItemData.append("ChanceRain: \(forecastItem.chanceRain)")
    }
}

