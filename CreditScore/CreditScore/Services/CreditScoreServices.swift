//
//  CreditScoreServices.swift
//  CreditScore
//
//  Created by Nitin George on 02/03/2021.
//

import Foundation
import Alamofire

final class CreditScoreServices: APICreditScoreProtocol {
    
    internal var apiService: APIService
    
    init() {
        apiService = APIService()
    }
    
    func fetchCreditScore(completion: @escaping (Bool, CreditScore?) -> Void) {
        let url = "\(AppConfiguration.apiURL)\(kFetchCreditScoreURL)"
        let params:[String: Any] = [:]
        let headers :HTTPHeaders = ["Accept":"application/json", "Content-Type":"application/json"]
        let request = ServiceRequest(url: url, headers: headers, parameters: params, method: .get)
        apiService.makeCall(request: request) { (isSuccess, response) in
            if let data = response, let decodedResponse = try? JSONDecoder().decode(CreditScore.self, from: data) {
                completion(true, decodedResponse)
            }
            else {
                completion(false, nil)
            }
        }
    }
}

