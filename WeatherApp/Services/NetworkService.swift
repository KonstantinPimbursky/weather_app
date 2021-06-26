//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 24.06.2021.
//

import Foundation
import Alamofire

class NetworkService {
    private let apiKey = "107e2da708b5767f8a8c4c925485a06c"
    static var shared = NetworkService()
    
    private init() {
        
    }
    
    func requestData(from url: URL) {
//        AF.request(url).responseJSON(completionHandler: { responseJSON in
//            
//        })
    }
}
