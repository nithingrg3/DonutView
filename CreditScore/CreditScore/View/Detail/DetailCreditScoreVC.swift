//
//  DetailCreditScoreVC.swift
//  CreditScore
//
//  Created by Nitin George on 02/03/2021.
//

import UIKit

class DetailCreditScoreVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        customNavBar()
    }
    
    internal static func instantiate(with creditScore: CreditScore?) -> DetailCreditScoreVC? {
        guard let vc = sb?.instantiateViewController(withIdentifier: "DetailCreditScoreVC") as? DetailCreditScoreVC else {
            return nil
        }
        print(creditScore as Any)
        return vc
    }
    
    func customNavBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        title = "Detail"
    }
}
