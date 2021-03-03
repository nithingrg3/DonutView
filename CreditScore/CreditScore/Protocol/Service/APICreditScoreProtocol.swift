//
//  APICreditScoreProtocol.swift
//  CreditScore
// 
//  Created by Nitin George on 02/03/2021.
//

import UIKit

protocol  APICreditScoreProtocol {
    func fetchCreditScore(completion: @escaping (_ isSuccess: Bool,_ creditScore: CreditScore?) -> Void)
}



