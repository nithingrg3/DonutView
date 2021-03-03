# DonutView
**Version 1.0**

Code and document for creating a Donut view based on your score
 -  Drwaing the DonutView using  CAShapeLayer and UIBezierPath
 
## Getting Started
If you are ready to play with the project just open `CreditScore.xcodeproj`. :rocket:
 
    <p align="center">
      <img src="./home.png" width="200" alt="VGS Show iOS SDK Aliases" hspace="10">
    </p>
    
    
# Demo
![alt-text](https://github.com/nithingrg3/DonutView/blob/main/donut.gif)
    
## DonutView Example

    The example shows how to create a Donut UI using `DonutView` swift class.

    var donutView = DonutView(frame: CGRect, myScore: Int?, totalScore: Int?, countingStartScore: Int?, radius: CGFloat)
    donutView.tag = 1
    
    //Delegate
    func donutViewScoreTouched(donutViewID: Int)
    
## Contributor
- Nithin George <nithingeorge3@gmail.com>

- [Requirements](#requirements)
- [Installation](#installation)
    - [Swift Package Manager](#swift-package-manager)
- [Architecture](#Architecture)
- [Target](#Target)
    
## Requirements
* iOS 13.0+
* macOS 10.15+
* Swift 5+

## Installation

### Swift Package Manager

In Xcode:
* File ⭢ Swift Packages ⭢ Add Package Dependency...
* Use the URL https://github.com/Alamofire/Alamofire.git

## Architecture 
* MVVM Architeture. Used Router for Navigation logic
* Followed TDD approch

## Target

* Production
* Staging
* Development
* UnitTest
* UITest


