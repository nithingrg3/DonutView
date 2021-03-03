//
//  Helper.swift
//  CreditScore
//
//  Created by Nitin George on 02/03/2021.
//

import Foundation
import UIKit

class Helper: NSObject {
    class func KeyWindow() -> UIWindow? {
        // getting access to the window object from SceneDelegate
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
          return nil
        }
        return sceneDelegate.window
    }
}
