//
//  DonutViewVMTests.swift
//  CreditScoreTests
//
//  Created by Nitin George on 02/03/2021.
//

import XCTest

class DonutViewVMTests: XCTestCase {

    var viewModel: DonutVMProtocol!
    
    override func setUpWithError() throws {
        viewModel = DonutViewVM(myScore: 507, totalScore: 700, countingStartScore: 100, radius: 100)
    }

    func testfetchMyScore() {
        XCTAssertTrue(viewModel.fetchMyScore() == 507)
    }
    
    func testfetchTotalScore() {
        XCTAssertTrue(viewModel.fetchTotalScore() == 700)
    }
    
    func testfetchCountingBaseScore() {
        XCTAssertTrue(viewModel.fetchCountingBaseScore() == 100)
    }
    
    func testfetchStartAngle() {
        XCTAssertTrue(viewModel.fetchStartAngle() == -CGFloat.pi / 2)
    }
    
    func testfetchOuterEndAngle() {
        XCTAssertTrue(viewModel.fetchOuterEndAngle() == 2 * CGFloat.pi)
    }
    
    func testfetchProgressCircleEndAngle() {
        XCTAssertTrue(viewModel.fetchProgressCircleEndAngle() == 3*CGFloat.pi/2)
    }
    
    func testfetchOuterCircleRadius() {
        XCTAssertTrue(viewModel.fetchOuterCircleRadius() == 100)
    }
    
    func testfetchProgressCircleRadiustest() {
        XCTAssertTrue(viewModel.fetchProgressCircleRadius() == 92.0)
    }
    
    func testfetchScoreLabelWandHC() {
        XCTAssertTrue(viewModel.fetchScoreLabelWandHC() == 180)
    }
    
    func testfetchCountingScoreText() {
        guard let score = viewModel.fetchCountingScoreText() else {
            XCTAssertFalse(true, "nil score object")
            return
        }
        XCTAssertTrue(score.mutableString == fetchCountingScoreText()?.mutableString)
    }
    
    func testmyScorePercentage() {
        guard let percentage = viewModel.myScorePercentage() else {
            XCTAssertFalse(true, "nil")
            return
        }
        XCTAssertTrue(percentage == 0.72428571428571431)
    }
    
    func testpercentageWithRadius() {
        XCTAssertTrue(viewModel.percentageWithRadius(of: 0.14) == 14.000000000000002)
    }
    
    func fetchCountingScoreText() -> NSMutableAttributedString? {
        let combination = NSMutableAttributedString()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        paragraphStyle.alignment   = .center
        let title = "Your credit score is \n"
        var range = (title as NSString).range(of: title)
        let titleAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        let titleName = NSMutableAttributedString(string: title, attributes: titleAttributes)
        titleName.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range)
        combination.append(titleName)
        let countScore = "132"
        range = (countScore as NSString).range(of: countScore)
        let scoreAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.thin)]
        let score = NSMutableAttributedString(string: countScore, attributes: scoreAttributes)
        score.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 242/255.0, green: 223/255.0, blue: 136/255.0, alpha: 1.0), range: range)
        combination.append(score)
        let outOfScore = "\n out of 700"
        range = (outOfScore as NSString).range(of: outOfScore)
        let totalAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        let total = NSMutableAttributedString(string: outOfScore, attributes: totalAttributes)
        total.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range)
        combination.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, combination.length))
        combination.append(total)
        return combination
    }
}
