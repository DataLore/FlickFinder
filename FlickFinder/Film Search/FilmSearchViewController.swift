//
//  FilmSearchViewController.swift
//  FlickFinder
//
//  Created by Phil Pepper on 02/03/2021.
//

import Foundation
import UIKit

final class FilmSearchViewController: UIViewController {
  
    //MARK: - State
    
    var viewModel: FilmSearchViewModel?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        resultView.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }
    
    //MARK: - Outlets
    
    @IBOutlet private weak var actorsLabel: UILabel!
    @IBOutlet private weak var directorLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var keyboardHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var plotLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var ratedLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var resultView: UIView!
    @IBOutlet private weak var runtimeLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var yearTextField: UITextField!
        
    //MARK: - Actions
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text else {
            return
        }
        viewModel?.search(title: title, for: yearTextField.text)
    }
    
    //MARK: - Functions
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut) {
            self.keyboardHeightConstraint.constant = 0
        }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn) {
                self.keyboardHeightConstraint.constant = keyboardSize.height
            }
        }
    }
    
    private func reload() {
        guard let viewState = viewModel?.filmSearchViewState else {
            showNoResultFoundWarning()
            return
        }
        resultView.isHidden = false
        titleLabel.text = viewState.title
        yearLabel.text = viewState.year
        ratedLabel.text = viewState.rated
        releaseDateLabel.text = viewState.released
        runtimeLabel.text = viewState.runtime
        genreLabel.text = viewState.genre
        directorLabel.text = viewState.director
        actorsLabel.text = viewState.actors
        plotLabel.text = viewState.plot
        languageLabel.text = viewState.language
        if let poster = viewState.poster {
            posterImageView.image = UIImage(data: poster)
        }
        view.layoutIfNeeded()
    }

}

extension FilmSearchViewController: FilmSearchScene {
    
    func showNoResultFoundWarning() {
        let alert = AlertFactory.buildNoResultFoundAlertController()
        resultView.isHidden = true
        present(alert, animated: true)
    }

    func showUpdatedContent() {
        reload()
    }
    
}
