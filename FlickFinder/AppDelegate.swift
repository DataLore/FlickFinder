//
//  AppDelegate.swift
//  FlickFinder
//
//  Created by Phil Pepper on 02/03/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = FilmSearchViewControllerFactory().viewController
        window?.makeKeyAndVisible()
        return true
    }

}

