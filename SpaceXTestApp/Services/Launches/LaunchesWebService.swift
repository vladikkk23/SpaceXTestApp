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
