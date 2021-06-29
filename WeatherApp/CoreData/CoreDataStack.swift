//
//  CoreDataStack.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 27.06.2021.
//

import Foundation
import CoreData

class CoreDataStack {
    private(set) lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "WeatherApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func newBackgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }

    func fetchForecastData() -> [ForecastData] {
        let request: NSFetchRequest<ForecastData> = ForecastData.fetchRequest()
        request.fetchBatchSize = 20
        do {
            return try viewContext.fetch(request)
        } catch {
            fatalError("🤷‍♂️ Что-то пошло не так..")
        }
    }

    func remove(forecastData: ForecastData) {
        viewContext.delete(forecastData)

        save(context: viewContext)
    }

    func createNewForecastData(forecast: ForecastModel) {
        let backgroundContext = newBackgroundContext()

        let newForecastData = ForecastData(context: backgroundContext)
        newForecastData.lat = forecast.lat
        newForecastData.lon = forecast.lon

        let newCurrentData = CurrentData(context: backgroundContext)
        newCurrentData.dt = forecast.current.dt
        newCurrentData.sunrise = forecast.current.sunrise
        newCurrentData.sunset = forecast.current.sunset
        newCurrentData.temp = forecast.current.temp
        newCurrentData.windSpeed = Int16(forecast.current.windSpeed)

        for weather in forecast.current.weather {
            let newCurrentWeather = WeatherData(context: backgroundContext)
            newCurrentWeather.weatherDescription = weather.weatherDescription
            newCurrentWeather.icon = weather.icon
            newCurrentData.addToWeather(newCurrentWeather)
        }

        let newCurrentRain = RainData(context: backgroundContext)
        newCurrentRain.oneHour = forecast.current.rain?.oneHour

        let newCurrentSnow = SnowData(context: backgroundContext)
        newCurrentSnow.oneHour = forecast.current.snow?.oneHour

        newCurrentData.rain = newCurrentRain
        newCurrentData.snow = newCurrentSnow
        newForecastData.current = newCurrentData

        for hourly in forecast.hourly {
            let newHourlyData = HourlyData(context: backgroundContext)
            newHourlyData.dt = hourly.dt
            newHourlyData.temp = hourly.temp
            newHourlyData.feelsLike = hourly.feelsLike
            newHourlyData.clouds = Int16(hourly.clouds)
            newHourlyData.windSpeed = hourly.windSpeed
            newHourlyData.windDeg = Int16(hourly.windDeg)
            newHourlyData.pop = Int16(hourly.pop)
            for weather in hourly.weather {
                let newCurrentWeather = WeatherData(context: backgroundContext)
                newCurrentWeather.weatherDescription = weather.weatherDescription
                newCurrentWeather.icon = weather.icon
                newHourlyData.addToWeather(newCurrentWeather)
            }
            newForecastData.addToHourly(newHourlyData)
        }
        
        for daily in forecast.daily {
            let newDailyData = DailyData(context: backgroundContext)
            newDailyData.dt = daily.dt
            newDailyData.sunrise = daily.sunrise
            newDailyData.sunset = daily.sunset
            newDailyData.windSpeed = daily.windSpeed
            newDailyData.windDeg = Int16(daily.windDeg)
            newDailyData.clouds = Int16(daily.clouds)
            newDailyData.pop = daily.pop
            newDailyData.uvi = daily.uvi
            
            let newTempData = TempData(context: backgroundContext)
            newTempData.day = daily.temp.day
            newTempData.min = daily.temp.min
            newTempData.max = daily.temp.max
            newTempData.night = daily.temp.night
            newDailyData.temp = newTempData
            
            let newFeelsLikeData = FeelsLikeData(context: backgroundContext)
            newFeelsLikeData.day = daily.feelsLike.day
            newFeelsLikeData.night = daily.feelsLike.night
            newDailyData.feelsLike = newFeelsLikeData
            
            for weather in daily.weather {
                let newWeatherData = WeatherData(context: backgroundContext)
                newWeatherData.weatherDescription = weather.weatherDescription
                newWeatherData.icon = weather.icon
                newDailyData.addToWeather(newWeatherData)
            }
            
            newForecastData.addToDaily(newDailyData)
        }

        backgroundContext.perform {
            do {
                try backgroundContext.save()
            } catch let error {
                print(error)
            }
        }
    }

    private func save(context: NSManagedObjectContext) {
        guard context.hasChanges else { return }

        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
