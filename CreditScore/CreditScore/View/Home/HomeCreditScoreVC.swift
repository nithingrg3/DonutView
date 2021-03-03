//
//  HomeCreditScoreVC.swift
//  CreditScore
//
//  Created by Nitin George on 02/03/2021.
//

import UIKit

class HomeCreditScoreVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var largeDonutView: UIView!
    @IBOutlet weak var smallDonutView: UIView!
    @IBOutlet weak var extraSmallDonutView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    private var apiManager: APICreditScoreProtocol!
    private var viewModel: HomeCreditScoreVMProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCreditScore()
        configureNavigationBar(largeTitleColor: UIColor.white, backgoundColor: UIColor.black, tintColor: UIColor.white, title: viewModel.fetchNavigationTitle(), preferredLargeTitle: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    internal static func instantiate(with viewModel: HomeCreditScoreVMProtocol) -> HomeCreditScoreVC? {
        guard let vc = sb?.instantiateViewController(withIdentifier: "HomeCreditScoreVC") as? HomeCreditScoreVC else {
            return nil
        }
        vc.viewModel = viewModel
        return vc
    }
    
    private func fetchCreditScore() {
        activityIndicator.startAnimating()
        viewModel.fetchCreditScore { [weak self] isSuccess in
            DispatchQueue.main.async {
                isSuccess ? self?.updateView() : self?.showErrorMessage()
            }
        }
    }
    
    private func loadLargeDonutView() {
        let donutview = DonutView(frame: largeDonutView.bounds,myScore: viewModel.fetchMyScore(),totalScore: viewModel.fetchTotalScore(),countingStartScore: viewModel.fetchCountingBaseScore(), radius: viewModel.fetchCircleRadius())
        donutview.tag = 1
        donutview.delegate = self
        largeDonutView.addSubview(donutview)
    }
    
    private func loadSmallDonutView() {
        let donutview = DonutView(frame: smallDonutView.bounds,myScore: 350,totalScore: viewModel.fetchTotalScore(),countingStartScore: viewModel.fetchCountingBaseScore(), radius: 75)
        donutview.delegate = self
        donutview.tag = 2
        smallDonutView.addSubview(donutview)
    }
    
    private func loadExtraSmallDonutView() {
        let donutview = DonutView(frame: extraSmallDonutView.bounds,myScore: 300,totalScore: viewModel.fetchTotalScore(),countingStartScore: viewModel.fetchCountingBaseScore(), radius: 60)
        donutview.delegate = self
        donutview.tag = 3
        extraSmallDonutView.addSubview(donutview)
    }
    
    private func updateView() {
        activityIndicator.stopAnimating()
        errorLabel.text = ""
        loadLargeDonutView()
        loadSmallDonutView()
        loadExtraSmallDonutView()
    }
    
    private func showErrorMessage() {
        errorLabel.text = viewModel.fetchErrorMessage()
    }
}

extension HomeCreditScoreVC: DonutViewDelegate {
    func donutViewScoreTouched(donutViewID: Int) {
        print("\(donutViewID)")
        let creditScore = viewModel.fetchSelectedCreditObject()
        AppRouter.pushDetailCreditScoreVC(navigationConroller: navigationController ?? UINavigationController(), creditScore: creditScore)
    }
}
