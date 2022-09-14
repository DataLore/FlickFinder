//
//  FilmSearchViewControllerFactory.swift
//  FlickFinder
//
//  Created by Phil Pepper on 03/03/2021.
//

import Foundation
import UIKit

struct FilmSearchViewControllerFactory: ViewControllerFactory {
    
    var viewController: UIViewController {
        let repository = DefaultFilmSearchRepository()
        let viewController = FilmSearchViewController.loadFromStoryboard()
        let viewModel = DefaultFilmSearchViewModel(
            repository: repository,
            scene: viewController
        )
        viewController.viewModel = viewModel
        return viewController
    }

}
