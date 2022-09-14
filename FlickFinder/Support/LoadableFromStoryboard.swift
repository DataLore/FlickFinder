//
//  LoadableFromStoryboard.swift
//  FlickFinder
//
//  Created by Phil Pepper on 03/03/2021.
//

import Foundation
import UIKit

public protocol LoadableFromStoryboard {}

extension LoadableFromStoryboard where Self: UIViewController {
    public static func loadFromStoryboard(named storyboardName: String? = nil, inBundle bundle: Bundle? = nil) -> Self {
        let storyboard = UIStoryboard(
            name: storyboardName ?? String(describing: Self.self),
            bundle: bundle ?? .main
        )
        
        guard let initalViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Uncable to intialiate view controller")
        }
        
        let viewController: UIViewController?
        if let initalViewController = initalViewController as? UINavigationController {
            viewController = initalViewController.children.first
        } else {
            viewController = initalViewController
        }
        
        guard let castedViewController = viewController as? Self else {
            fatalError("Cannot cast \(String(describing: viewController)) into instance of \(Self.self)")
        }
        
        return castedViewController
    }
}

extension UIViewController: LoadableFromStoryboard {}
