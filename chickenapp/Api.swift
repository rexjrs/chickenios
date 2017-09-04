//
//  Api.swift
//  chickenapp
//
//  Created by Thomas on 8/30/2560 BE.
//  Copyright © 2560 unicity. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public func getMedia(completion: @escaping ([[String : Any]]) -> ()){
    Alamofire.request(URL(string: MEDIA_URL)!,
        method: .get)
        .responseJSON(completionHandler: {(response) -> Void in
            if let value = response.result.value{
                completion(value as! [[String : Any]])
            }
        }
    )
}

public func getNews(completion: @escaping ([[String : Any]]) -> ()){
    Alamofire.request(URL(string: NEWS_URL)!,
        method: .get)
        .responseJSON(completionHandler: {(response) -> Void in
            if let value = response.result.value{
                completion(value as! [[String : Any]])
            }
        }
    )
}

public func authenticate(userPass: String, completion: @escaping (JSON) -> ()){
    let params = [
        "type":"base64",
        "value": userPass,
        "namespace":"https://hydra.unicity.net/v5/customers"
    ]
    
    let header = [
        "Content-Type":"application/json;charset=utf-8"
    ]
    
    Alamofire.request(URL(string: LOGIN_TOKENS)!,
        method: .post,
        parameters: params,
        encoding: JSONEncoding.default,
        headers: header)
        .responseJSON(completionHandler: {(response) -> Void in
            if let value = response.result.value{
                let finalValue = JSON(value)
                completion(finalValue)
            }
        }
    )
}

public func getUserData(token: String, href: String, completion: @escaping (JSON) -> ()){
    let header = [
        "Authorization":"Bearer "+token
    ]
    Alamofire.request(URL(string: href+"?expand=metricsProfile,metricsProfileHistory,profilePicture,achievementsHistory,cumulativeMetricsProfile")!,
        method: .get,
        encoding: JSONEncoding.default,
        headers: header)
        .responseJSON(completionHandler: {(response) -> Void in
            if let value = response.result.value{
                let finalValue = JSON(value)
                completion(finalValue)
            }
        }
    )
}

public func getReport(token: String, month: String, completion: @escaping ([[String : Any]]) -> ()){
    Alamofire.request(URL(string: (ORDER_HISTORY+token+"&month="+month))!,
        method: .get)
        .responseJSON(completionHandler: {(response) -> Void in
            if let value = response.result.value{
                completion(value as! [[String : Any]])
            }
        }
    )
}
