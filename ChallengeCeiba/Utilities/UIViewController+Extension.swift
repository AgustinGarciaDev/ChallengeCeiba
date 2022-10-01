//
//  UIViewController+Extension.swift
//  ChallengeCeiba
//
//  Created by Agustinch on 29/09/2022.
//

import Foundation
import UIKit


extension UIViewController {

    func showSheetController(with viewController: UIViewController){
        if #available(iOS 15.0, *) {
            if let sheetViewController = viewController.sheetPresentationController {
                sheetViewController.detents = [.medium()]
                sheetViewController.selectedDetentIdentifier = .medium
                sheetViewController.prefersGrabberVisible = true
                sheetViewController.preferredCornerRadius = 20
            }
        }
       
        self.present(viewController, animated: true, completion: nil)
    }
}
