//
//  ServiceRequest.swift
//  CreditScore
//
//  Created by Nitin George on 02/03/2021.
//

import Alamofire

struct ServiceRequest {
    var url: String
    var headers: HTTPHeaders?
    var parameters: [String: Any]?
    var method: HTTPMethod
}
