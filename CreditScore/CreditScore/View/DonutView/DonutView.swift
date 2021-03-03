//
//  DonutView.swift
//  sdfgv
//
//  Created by Nitin George on 02/03/2021.
//

import UIKit

protocol DonutViewDelegate: class {
    func donutViewScoreTouched(donutViewID: Int)
}

class DonutView: UIView {
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreLblHC: NSLayoutConstraint!
    @IBOutlet weak var scoreLblWC: NSLayoutConstraint!
    
    private var progressLayer = CAShapeLayer()
    private var trackLayer = CAShapeLayer()
    private let shapeLayer = CAShapeLayer()
    private var viewModel: DonutVMProtocol!
    weak var delegate:DonutViewDelegate? = nil
    
    var progressColor = UIColor(red: 238/255.0, green: 209/255.0, blue: 123/255.0, alpha: 1.0)  {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    private let myScoreColor = UIColor(red: 242/255.0, green: 223/255.0, blue: 136/255.0, alpha: 1.0)
    
    var trackColor = UIColor.white {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init(frame: CGRect, myScore: Int?, totalScore: Int?, countingStartScore: Int?, radius: CGFloat) {
        super.init(frame: frame)
        viewModel = DonutViewVM(myScore: myScore, totalScore: totalScore, countingStartScore: countingStartScore, radius: radius)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func initUI() {
        addTapGesture()
        initializeSubviews()
        startCountMyScore()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int(0.4)), execute: { [weak self] in
            self?.updateViewConstraints()
            self?.outerCircleLayer()
            self?.createProgressCirclePath()
            let percetage = self?.viewModel.myScorePercentage() ?? 0.0
            self?.setProgressWithAnimation(duration: 1.5, value: Float(percetage))
        })
    }
    
    private func addTapGesture() {
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(scoreTapped(tapGestureRecognizer:))))
    }
    
    private func prepareCell(viewModel: DonutViewVM) {
        self.viewModel = viewModel
    }
    
    private func initializeSubviews() {
        let viewName = "DonutView"
        let view: UIView = Bundle.main.loadNibNamed(viewName,owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    private func updateViewConstraints() {
        let updatedValue = viewModel.fetchScoreLabelWandHC()
        scoreLblHC.constant = updatedValue
        scoreLblWC.constant = updatedValue
    }
    
    private func startCountMyScore() {
        _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] timer in
            if (self?.viewModel.fetchCountingBaseScore() ?? 0) > (self?.viewModel.fetchMyScore() ?? 0) {timer.invalidate()}
            DispatchQueue.main.async {
                if self?.viewModel.fetchCountingBaseScore() ?? 0 < self?.viewModel.fetchMyScore() ?? 0 {
                    self?.scoreLabel.attributedText = self?.viewModel.fetchCountingScoreText()
                }
            }
        })
    }
    
    private func outerCircleLayer() {
        let center = outerView.center
        let trackLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: center, radius: viewModel.fetchOuterCircleRadius(), startAngle: viewModel.fetchStartAngle(), endAngle: viewModel.fetchOuterEndAngle(), clockwise: true)
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.black.cgColor
        trackLayer.lineWidth = CGFloat(viewModel.percentageWithRadius(of: 0.02))
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        self.layer.addSublayer(trackLayer)
    }
    
    // Circle --> Counter clockwise values (1,0) -> π, (0, 1) -> π/2, (-1, 0) -> π, (0, -1) -> 3π/2, (1, 0) -> 2π
    private func createProgressCirclePath() {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = self.frame.size.width/2
        let circlePath = UIBezierPath(arcCenter: outerView.center, radius: viewModel.fetchProgressCircleRadius(), startAngle: viewModel.fetchStartAngle(), endAngle: viewModel.fetchProgressCircleEndAngle(), clockwise: true)
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth =  CGFloat(viewModel.percentageWithRadius(of: 0.06))
        progressLayer.strokeEnd = 0.0
        progressLayer.lineCap = CAShapeLayerLineCap.round
        layer.addSublayer(progressLayer)
    }
    
    private func setProgressWithAnimation(duration: TimeInterval, value: Float) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = value
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        progressLayer.strokeEnd = CGFloat(value)
        progressLayer.add(animation, forKey: "animateprogress")
    }
}

// MARK: Button Actions
extension DonutView {
    @objc func scoreTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        delegate?.donutViewScoreTouched(donutViewID: self.tag)
    }
}
