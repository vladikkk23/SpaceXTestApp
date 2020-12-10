//
//  UIView_ext.swift
//  SpaceXTestApp
//
//  Created by vladikkk on 10/12/2020.
//

import UIKit

// Get current View Controller
extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? LaunchListVC {
            return nextResponder
        }  else if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}
