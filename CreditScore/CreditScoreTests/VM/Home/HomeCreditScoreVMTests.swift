//
//  CreditScoreListVMTests.swift
//  CreditScoreTests
//
//  Created by Nitin George on 02/03/2021.
//

import XCTest

class CreditScoreListVMTests: XCTestCase {

    var apiManager: APICreditScoreProtocol = CreditScoreServicesMock()
    var viewModel: HomeCreditScoreVMProtocol!
    
    override func setUp() {
        super.setUp()
        viewModel = CreditScoreListVM(apiManager: apiManager)
        viewModel.fetchCreditScore { (isSuccess) in
            XCTAssertTrue(isSuccess)
        }
    }
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {

    }
    
    func testNavigationTitle() {
        XCTAssertTrue(viewModel.fetchNavigationTitle() == NSLocalizedString("Dashboard", comment: ""))
    }

    func testErrorMessage() {
        XCTAssertTrue(viewModel.fetchErrorMessage() == NSLocalizedString("NoCreditScoreErrorMessage", comment: ""))
    }
    
    func testfetchMyScore() {
        XCTAssertTrue(viewModel.fetchMyScore() == 514)
    }
    
    func testfetchTotalScore() {
        XCTAssertTrue(viewModel.fetchTotalScore() == 700)
    }
    
    func testfetchCountingBaseScore() {
        XCTAssertTrue(viewModel.fetchCountingBaseScore() == 100)
    }
    
    func testfetchCircleRadius() {
        XCTAssertTrue(viewModel.fetchCircleRadius() == 150)
    }
    
    func testfetchSelectedCreditObject() {
        
        guard let scoreObj = viewModel.fetchSelectedCreditObject() else {
            XCTAssertFalse(true, "nil score object")
            return
        }
        XCTAssertTrue(scoreObj.creditReportInfo?.clientRef == "CS-SED-655426-708782")
    }
}
