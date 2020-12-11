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
    private var URLString = "https://api.spacexdata.com/v4/launches"
    
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
                // Format date
                let date = Date(timeIntervalSince1970: Double(unixDate))
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                dateFormatter.locale = NSLocale.current
                dateFormatter.dateFormat = "MMMM d, yyyy"
                let strDate = dateFormatter.string(from: date)
                
                launchData.date = strDate
            }
            
            if let flickrImages = try? decoder.decode(FlickrData.self, from: data, keyPath: "links.flickr") {
                launchData.flickrImages = flickrImages
            } else if let images = try? decoder.decode(PatchData.self, from: data, keyPath: "links.patch") {
                launchData.patchData = images
            }
            
            if let videoLink = try? decoder.decode(String.self, from: data, keyPath: "links.youtube_id") {
                launchData.videoLink = "https://www.youtube.com/embed/\(videoLink)"
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
            
            if let link = try? decoder.decode(String.self, from: data, keyPath: "links.wikipedia") {
                launchData.wikipediaLink = link
            }
            
            // Parse data to controller
            completionHandler(launchData)
        }
    }
    
    // MARK: Methods
    func getLaunch(completionHandler: @escaping ([LaunchDataResponse]?) -> Void) {
        self.genericRequests.HTTPGetRequest(stringURL: self.URLString) { (genericData) in
            guard let data = genericData else {
                return
            }
                        
            // Decode data
            let decoder = JSONDecoder()
            
            guard let launchData = try? decoder.decode([LaunchDataResponse].self, from: data) else {
                return
            }

            // Parse data to controller
            completionHandler(launchData)
        }
    }
}
