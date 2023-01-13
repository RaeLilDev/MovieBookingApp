//
//  SideMenuViewController.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 4/29/22.
//

import UIKit

class SideMenuViewController: UIViewController {

    @IBOutlet weak var viewLogout: UIStackView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var ivProfile: UIImageView!
    
    private let authModel = AuthenticationModelImpl.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchProfileInfo()
        
        registerGestureRecognizer()
    }
    
    private func registerGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapLogout))
        viewLogout.isUserInteractionEnabled = true
        viewLogout.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    private func fetchProfileInfo() {
        authModel.getUserProfileInfo { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.bindData(data: data)
                
            case .failure(let message):
                print(message)
            }
            
        }
    }
    
    private func bindData(data: ProfileVO) {
        lblName.text = data.name
        lblEmail.text = data.email
        
        let profilePath = "\(AppConstants.BaseURL)/\(data.profileImage)"
        
        ivProfile.sd_setImage(with: URL(string: profilePath))
    }
    
    @objc func onTapLogout() {
        authModel.logout { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                print(data)
                self.navigateToAuthenticationViewController()
            case .failure(let message):
                print(message)
            }
        }
        
    }

}
