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
    
    func getRecordsFromApi(searchString: String, pageNumber: Int, itemsPerPage: Int, completion: @escaping (Bool, ApiResponse?) -> Void) {
        
        let parameters: [String: Any] = [
            "force-plp" : true,
            "search-string" : searchString,
            "page-number" : pageNumber,
            "number-of-items-per-page" : itemsPerPage
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
                completion(true, apiResponse)
            case .failure(_):
                debugPrint("no records found")
                completion(false, nil)
            }
            
    }
        
}
}
