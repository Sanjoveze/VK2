//
//  NetworkService.swift
//  vk
//
//  Created by Rafael Khanov on 12.05.2020.
//  Copyright © 2020 Rafael Khanov. All rights reserved.
//

import Foundation
import Alamofire

 class NetworkService {
     
     let baseURL = "https://api.vk.com/method/"
     
    func getRequest<T>(method: String,
                       parametersName: String,
                       parametersDescription: String,
                       parse: @escaping ((Data) -> T),
                       completion: @escaping (T) -> Void)  {

         let parameter: Parameters = [
             "access_token": Session.shared.token,
             method: method,
             parametersName: parametersDescription,
             "extended": 1,
             "v": "5.103"
         ]
        
         let url = baseURL + method
         
         AF.request(url, method: .get, parameters: parameter).responseJSON { response in
             
             guard
                let data = response.data
           
             else {
                 print("error")
                 return
             }
            let result = parse(data)
            
             completion(result)
         }
     }
     
 }

