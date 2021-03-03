//
//  CreditScoreServicesMock.swift
//  CreditScore
//
//  Created by Nitin George on 02/03/2021.
//

import Foundation
import UIKit

final class CreditScoreServicesMock: APICreditScoreProtocol {
    func fetchCreditScore(completion: @escaping (Bool, CreditScore?) -> Void) {
        var apiResult:Data?
        do {
            apiResult = try Data.init(contentsOf: Bundle.main.url(forResource: "MockCreditScore", withExtension: "json")!)
            if let apiResult = apiResult {
                let creditScore = try JSONDecoder().decode(CreditScore.self, from: apiResult)
                completion(true, creditScore)
            }
        } catch _ as NSError {
            completion(false, nil)
        }
    }
}
