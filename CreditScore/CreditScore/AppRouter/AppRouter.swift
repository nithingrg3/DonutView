//
//  AppRouter.swift
//  CreditScore
//
//  Created by Nitin George on 02/03/2021.
//

import Foundation
import UIKit

enum NavigationState {
    case start
}

final class AppRouter {
    private static var currentState: NavigationState = .start
    
    static func newState(_ state: NavigationState) {
        currentState = state
        switch state {
        case .start:
            let viewModel = CreditScoreListVM(apiManager: CreditScoreServices())
            guard let creditScoreHomeVC = HomeCreditScoreVC.instantiate(with: viewModel)  else {
                return
            }
            let navController = UINavigationController(rootViewController: creditScoreHomeVC)
            Helper.KeyWindow()?.rootViewController = navController
        }
        Helper.KeyWindow()?.makeKeyAndVisible()
    }

    static func pushDetailCreditScoreVC(navigationConroller :UINavigationController, creditScore: CreditScore?) {
        guard let detailVC = DetailCreditScoreVC.instantiate(with: creditScore) else {
            return
        }
        navigationConroller.pushViewController(detailVC,animated: true)
    }
}



