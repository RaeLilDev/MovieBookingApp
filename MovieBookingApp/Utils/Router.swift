//
//  Router.swift
//  MovieBookingApp
//
//  Created by Ye Lynn Htet on 20/02/2022.
//

import Foundation
import UIKit

enum StoryboardName: String {
    case Main = "Main"
    case Authentication = "Authentication"
    case LaunchScreen = "LaunchScreen"
}

extension UIStoryboard {
    static func mainStoryboard()->UIStoryboard {
        return UIStoryboard(name: StoryboardName.Main.rawValue, bundle: nil)
    }
    
    static func authenticationStoryboard()->UIStoryboard {
        return UIStoryboard(name: StoryboardName.Authentication.rawValue, bundle: nil)
    }
}

extension UIViewController {
    
    func navigateToAuthenticationViewController() {
        guard let vc = UIStoryboard.authenticationStoryboard().instantiateViewController(withIdentifier: AuthenticationViewController.identifier) as? AuthenticationViewController else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    
    func navigateToHomeViewController() {
        guard let vc = UIStoryboard.mainStoryboard().instantiateViewController(withIdentifier: ViewController.identifier) as? ViewController else { return }
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func navigateToMovieDetailViewController(movieId: Int) {
        guard let vc = UIStoryboard.mainStoryboard().instantiateViewController(withIdentifier: MovieDetailViewController.identifier) as? MovieDetailViewController else { return }
        vc.movieId = movieId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToMovieTimeViewController() {
        guard let vc = UIStoryboard.mainStoryboard().instantiateViewController(withIdentifier: MovieTimeViewController.identifier) as? MovieTimeViewController else { return }

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToMovieSeatViewController() {
        guard let vc = UIStoryboard.mainStoryboard().instantiateViewController(withIdentifier: MovieSeatViewController.identifier) as? MovieSeatViewController else { return }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToSnackViewController(ticketPrice: Int) {
        guard let vc = UIStoryboard.mainStoryboard().instantiateViewController(withIdentifier: SnackViewController.identifier) as? SnackViewController else { return }
        vc.ticketPrice = ticketPrice
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToPaymentViewController(totalPrice: Int) {
        guard let vc = UIStoryboard.mainStoryboard().instantiateViewController(withIdentifier: PaymentViewController.identifier) as? PaymentViewController else { return }
        vc.totalPrice = totalPrice
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToAddNewCardViewController() {
        guard let vc = UIStoryboard.mainStoryboard().instantiateViewController(withIdentifier: AddNewCardViewController.identifier) as? AddNewCardViewController else { return }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToTicketViewController(checkout: CheckoutVO) {
        guard let vc = UIStoryboard.mainStoryboard().instantiateViewController(withIdentifier: TicketViewController.identifier) as? TicketViewController else { return }
        vc.checkout = checkout
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToRootViewController() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
