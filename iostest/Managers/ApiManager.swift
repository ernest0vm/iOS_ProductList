//
//  ApiManager.swift
//  iostest
//
//  Created by Ernesto Valdez on 30/06/20.
//  Copyright © 2020 Ernesto Valdez. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiManager {
    static var shared = ApiManager()
    let BASE_URL: String = "https://shoppapp.liverpool.com.mx/appclienteservices/services/v3/plp"
    
    func getRecordsFromApi(searchString: String, completion: @escaping (Bool, [Record]) -> Void) {
        
        let parameters: [String: Any] = [
            "force-plp" : true,
            "search-string" : searchString,
            "page-number" : 1,
            "number-of-items-per-page" : 5
        ]
        
        Alamofire.request(
            BASE_URL,
            method: .get,
            parameters: parameters
        ).responseJSON { response in
            
            switch (response.result){
                
            case .success(_):
                let apiResponse = try? JSONDecoder().decode(ApiResponse.self, from: response.data!)
                debugPrint("records found: \(apiResponse?.plpResults.records.count ?? 0)")
                completion(true, (apiResponse?.plpResults.records)!)
            case .failure(_):
                debugPrint("no records found")
                completion(false, [Record]())
            }
            
            
        }
    }
    
}
