//
//  UIViewControllerExt.swift
//  mapChallenge
//
//  Created by Sky on 19/09/2021.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, msg: String) {
        let controller = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Got it!", style: .cancel, handler: nil))
        self.present(controller, animated: true, completion: nil)
    }
}
