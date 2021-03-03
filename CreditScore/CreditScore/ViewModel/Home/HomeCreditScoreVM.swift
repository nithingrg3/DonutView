//
//  CreditScoreListVM.swift
//  CreditScore
//
//  Created by Nitin George on 02/03/2021.
//

import UIKit

class CreditScoreListVM: HomeCreditScoreVMProtocol {

    private var creditScore: CreditScore?
    
    private var apiManager: APICreditScoreProtocol?

    required init(apiManager: APICreditScoreProtocol) {
        self.apiManager = apiManager
    }
    
    func fetchNavigationTitle() -> String {
        return NSLocalizedString("Dashboard", comment: "")
    }
    
    func fetchCreditScore(completion: @escaping (Bool) -> Void) {
        apiManager?.fetchCreditScore(completion: { [weak self](isSucess, creditScore) in
            if isSucess {
                guard let creditScore = creditScore else {
                    completion(true)
                    return
                }
                self?.creditScore = creditScore
                completion(true)
            }
            else {
                completion(false)
            }
        })
    }
    
    func fetchErrorMessage() -> String {
        return NSLocalizedString("NoCreditScoreErrorMessage", comment: "")
    }
    
    func fetchMyScore() -> Int {
        return creditScore?.creditReportInfo?.score ?? 0
    }
    
    func fetchTotalScore() -> Int {
        return creditScore?.creditReportInfo?.maxScoreValue ?? 0
    }
    
    func fetchCountingBaseScore() -> Int {
        return 100
    }
    
    func fetchCircleRadius() -> CGFloat {
        return 150.0
    }
    
    func fetchSelectedCreditObject() -> CreditScore? {
        return creditScore
    }
}

