//
//  AlertFactory.swift
//  FlickFinder
//
//  Created by Phil Pepper on 03/03/2021.
//

import Foundation
import UIKit

struct AlertFactory {

    private static func addOkButton(
        to alertController: UIAlertController,
        with completion: @escaping () -> Void = {}
    ) {
        alertController.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: { _ in completion() }
            )
        )
    }
    
    static func buildNoResultFoundAlertController() -> UIAlertController {
        let alertController = UIAlertController(
            title: NSLocalizedString(
                "lNoResultFoundAlertTitle",
                comment: "Title of an alert when no result is found for displayed."
            ),
            message: NSLocalizedString(
                "lNoResultFoundAlertMessage",
                comment: "Message of an alert when no result is found for displayed."
            ),
            preferredStyle: .alert
        )
        
        addOkButton(to: alertController)
        
        return alertController
    }
    
}
