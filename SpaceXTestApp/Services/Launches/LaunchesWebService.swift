//
//  LaunchesWebService.swift
//  SpaceXTestApp
//
//  Created by vladikkk on 10/12/2020.
//

import Foundation

class LaunchesWebService {
    // MARK: Properties
    
    // Perform requests
    private let genericRequests = GenericHTTPRequests()
    
    // URL string
    private var URLString = "https://api.spacexdata.com/v4/launches/latest"
    
    // MARK: Methods
    func getLaunches(completionHandler: @escaping (LaunchData?) -> Void) {
        self.genericRequests.HTTPGetRequest(stringURL: self.URLString) { (genericData) in
            guard let data = genericData else {
                return
            }
            
            var launchData = LaunchData()
            
            // Decode data
            let decoder = JSONDecoder()
            
            if let name = try? decoder.decode(String.self, from: data, keyPath: "name") {
                launchData.name = name
            }
            
            if let unixDate = try? decoder.decode(Int.self, from: data, keyPath: "date_unix") {
                // format date
                let date = Date(timeIntervalSince1970: Double(unixDate))
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                dateFormatter.locale = NSLocale.current
                dateFormatter.dateFormat = "MMMM d, yyyy"
                let strDate = dateFormatter.string(from: date)
                
                launchData.date = strDate
            }
            
            if let images = try? decoder.decode(PatchData.self, from: data, keyPath: "links.patch") {
                launchData.patchData = images
            }
            
            if let videoLink = try? decoder.decode(String.self, from: data, keyPath: "links.webcast") {
                launchData.videoLink = videoLink
            }
            
            if let description = try? decoder.decode(String.self, from: data, keyPath: "details") {
                launchData.description = description
            }
            
            if let rocketName = try? decoder.decode(String.self, from: data, keyPath: "rocket") {
                launchData.rocketName = rocketName
            }
            
            if let payloads = try? decoder.decode([String].self, from: data, keyPath: "payloads"), !payloads.isEmpty {
                launchData.payloads = payloads
            }
            
            // Parse data to controller
            completionHandler(launchData)
        }
    }
}
