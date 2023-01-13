//
//  WelcomeViewController.swift
//  MovieBookingApp
//
//  Created by Ye Lynn Htet on 20/02/2022.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var btnGetStarted: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initBtnGetStarted()
        
    }
    
    

    func initBtnGetStarted() {
        btnGetStarted.layer.borderWidth = 1
        btnGetStarted.layer.borderColor = UIColor.white.cgColor
        btnGetStarted.layer.cornerRadius = 4
        
        btnGetStarted.accessibilityIdentifier = "get_started_button"
    }
    
    @IBAction func btnGetStartedTapped(_ sender: UIButton) {
        navigateToAuthenticationViewController()
    }
    
    

}
