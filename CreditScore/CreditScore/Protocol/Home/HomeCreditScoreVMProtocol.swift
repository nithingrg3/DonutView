//
//  HomeCreditScoreVMProtocol.swift
//  CreditScore
//
//  Created by Nitin George on 02/03/2021.
//

import UIKit

protocol  HomeCreditScoreVMProtocol {
    func fetchNavigationTitle() -> String
    func fetchCreditScore(completion: @escaping (_ isSuccess: Bool) -> Void)
    func fetchMyScore() -> Int
    func fetchTotalScore() -> Int
    func fetchCountingBaseScore() -> Int
    func fetchCircleRadius() -> CGFloat
    func fetchErrorMessage() -> String
    func fetchSelectedCreditObject() -> CreditScore?
}
