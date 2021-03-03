//
//  CreditScoreViewCellVM.swift
//  CreditScore
//
//  Created by Nitin George on 02/03/2021.
//

import UIKit

private struct DonutViewConstants {
    static let scoreTitle = "Your credit score is"
    static let outOfText  = "out of"
}

class DonutViewVM: DonutVMProtocol {
    
    private let startAngle: CGFloat = -CGFloat.pi / 2
    private let outerEndAngle: CGFloat = 2 * CGFloat.pi
    private let progressCircleEndAngle: CGFloat = 3*CGFloat.pi/2
    private var outerRadius: CGFloat = 0.0
    private var titleAttributesSize:CGFloat = 14
    private var scoreAttributesSize:CGFloat = 40
    private var totalAttributesSize:CGFloat = 14
    private var myScore:Int?
    private var totalScore:Int?
    private var countingStartScore:Int?

    
//    fileprivate var progressColor = UIColor(red: 238/255.0, green: 209/255.0, blue: 123/255.0, alpha: 1.0)  {
//        didSet {
//            progressLayer.strokeColor = progressColor.cgColor
//        }
//    }
    
    fileprivate let myScoreColor = UIColor(red: 242/255.0, green: 223/255.0, blue: 136/255.0, alpha: 1.0)
    
//    fileprivate var trackColor = UIColor.white {
//        didSet {
//            trackLayer.strokeColor = trackColor.cgColor
//        }
//    }
    
    required init(myScore: Int?, totalScore: Int?, countingStartScore: Int?, radius: CGFloat) {
        self.myScore = myScore
        self.totalScore = totalScore
        self.countingStartScore = countingStartScore
        outerRadius = CGFloat(radius)
        calculateTextFontSize()
    }
    
    func calculateTextFontSize() {
        titleAttributesSize = percentageWithRadius(of: titleAttributesSize / 100)
        scoreAttributesSize = percentageWithRadius(of: scoreAttributesSize / 100)
        totalAttributesSize = percentageWithRadius(of: totalAttributesSize / 100)
    }
    
    func fetchMyScore() -> Int {
        return myScore ?? 0
    }
    
    func fetchTotalScore() -> Int {
        return totalScore ?? 0
    }
    
    func fetchCountingBaseScore() -> Int {
        return countingStartScore ?? 0
    }
    
    func fetchStartAngle() -> CGFloat {
        return startAngle
    }
    
    func fetchOuterEndAngle() -> CGFloat {
        return outerEndAngle
    }
    
    func fetchProgressCircleEndAngle() -> CGFloat {
        return progressCircleEndAngle
    }
    
    func fetchOuterCircleRadius() -> CGFloat {
        return outerRadius
    }
    
    func fetchProgressCircleRadius() -> CGFloat {
        return fetchOuterCircleRadius() - CGFloat(percentageWithRadius(of: 0.08))
    }
    
    func fetchScoreLabelWandHC() -> CGFloat {
        let diameter = 2 * fetchOuterCircleRadius()
        return diameter - 20
    }
    
    func fetchCountingScoreText() -> NSMutableAttributedString? {
        let combination = NSMutableAttributedString()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = CGFloat(percentageWithRadius(of: 0.10))
        paragraphStyle.alignment   = .center
        
        let myscore = fetchMyScore()
        countingStartScore = (countingStartScore ?? 0) + 32
        
        let title = "\(DonutViewConstants.scoreTitle) \n"
        var range = (title as NSString).range(of: title)
        let titleAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: titleAttributesSize)]
        let titleName = NSMutableAttributedString(string: title, attributes: titleAttributes)
        titleName.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range)

        combination.append(titleName)
        
        let countScore = "\((countingStartScore ?? 0) > myscore ? myscore : (countingStartScore ?? 0))"
        range = (countScore as NSString).range(of: countScore)
        let scoreAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: scoreAttributesSize, weight: UIFont.Weight.thin)]
        let score = NSMutableAttributedString(string: countScore, attributes: scoreAttributes)
        score.addAttribute(NSAttributedString.Key.foregroundColor, value: myScoreColor, range: range)
        combination.append(score)
        
        let outOfScore = "\n \(DonutViewConstants.outOfText) \(fetchTotalScore())"
        range = (outOfScore as NSString).range(of: outOfScore)
        let totalAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: totalAttributesSize)]
        let total = NSMutableAttributedString(string: outOfScore, attributes: totalAttributes)
        total.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range)
        
        combination.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, combination.length))
        combination.append(total)
        return combination
    }
    
    func myScorePercentage() -> Double? {
        return Double(fetchMyScore()) / Double(fetchTotalScore())
    }
    
    func percentageWithRadius(of percentage: CGFloat) -> CGFloat {
        return fetchOuterCircleRadius() * percentage
    }
}

