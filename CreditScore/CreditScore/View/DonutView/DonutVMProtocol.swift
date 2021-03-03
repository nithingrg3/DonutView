//
//  DonutVMProtocol.swift
//  CreditScore
//
//  Created by Nitin George on 02/03/2021.
//

import UIKit

protocol DonutVMProtocol {
    func fetchMyScore() -> Int
    func fetchTotalScore() -> Int
    func myScorePercentage() -> Double?
    func fetchCountingBaseScore() -> Int
    func fetchStartAngle() -> CGFloat
    func fetchOuterEndAngle() -> CGFloat
    func fetchProgressCircleEndAngle() -> CGFloat
    func fetchOuterCircleRadius() -> CGFloat
    func fetchProgressCircleRadius() -> CGFloat
    func fetchCountingScoreText() -> NSMutableAttributedString?
    func fetchScoreLabelWandHC() -> CGFloat
    func percentageWithRadius(of percentage: CGFloat) -> CGFloat
}
