//
//  AuthenticationViewController.swift
//  MovieBookingApp
//
//  Created by Ye Lynn Htet on 20/02/2022.
//

import UIKit

class AuthenticationViewController: UIViewController {

    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var txtFieldUsername: UITextField!
    @IBOutlet weak var txtFieldPhone: UITextField!
    
    @IBOutlet weak var lblSigninForgotPwd: UILabel!
    @IBOutlet weak var lblLoginForgotPwd: UILabel!
    @IBOutlet weak var lblLogin: UILabel!
    @IBOutlet weak var lblSignIn: UILabel!
    @IBOutlet weak var overlayLogin: UIView!
    @IBOutlet weak var overlaySignIn: UIView!
    
    @IBOutlet weak var containerUsername: UIStackView!
    @IBOutlet weak var containerPhone: UIStackView!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnGoogle: UIButton!
    
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var containerError: UIView!
    
    let googleAuth = GoogleAuth()
    
    
    private let networkAgent: AuthenticationModel = AuthenticationModelImpl.shared
    
    var isLoginSelected = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTxtField()
        
        initLoginView()
        
        initButtonBorders()
        
        initGestureRecognizers()
        
        hideErrorView()
        
    }
    
    private func hideErrorView() {
        containerError.isHidden = true
    }
    
    func initGestureRecognizers() {
        let loginGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(loginTapped))
        lblLogin.isUserInteractionEnabled = true
        lblLogin.addGestureRecognizer(loginGestureRecognizer)
        
        let signInGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(signInTapped))
        lblSignIn.isUserInteractionEnabled = true
        lblSignIn.addGestureRecognizer(signInGestureRecognizer)
    }
    
    @objc func loginTapped() {
        initLoginView()
        
        isLoginSelected = true
    }
    
    
    @objc func signInTapped() {
        initSignInView()
        
        isLoginSelected = false
    }
    
    func initLoginView() {
        overlayLogin.backgroundColor = UIColor(named: "primary_color")
        overlaySignIn.backgroundColor = UIColor(named: "color_white")
        lblSignIn.textColor = UIColor(named: "color_dark_gray")
        lblLogin.textColor = UIColor(named: "primary_color")
        lblSigninForgotPwd.isHidden = true
        lblLoginForgotPwd.isHidden = false
        hideUsernameAndPhone()
    }
    
    func initSignInView() {
        overlayLogin.backgroundColor = UIColor(named: "color_white")
        overlaySignIn.backgroundColor = UIColor(named: "primary_color")
        lblSignIn.textColor = UIColor(named: "primary_color")
        lblLogin.textColor = UIColor(named: "color_dark_gray")
        lblLoginForgotPwd.isHidden = true
        lblSigninForgotPwd.isHidden = false
        showUsernameAndPhone()
    }
    
    func initTxtField() {
        txtFieldEmail.setUpUnderline()
        txtFieldPassword.setUpUnderline()
        txtFieldUsername.setUpUnderline()
        txtFieldPhone.setUpUnderline()
    }
    
    func hideUsernameAndPhone() {
        containerUsername.isHidden = true
        containerPhone.isHidden = true
        
    }
    
    func showUsernameAndPhone() {
        containerUsername.isHidden = false
        containerPhone.isHidden = false
    }
    
    func initButtonBorders() {
        btnFacebook.layer.borderWidth = 0.5
        btnFacebook.layer.borderColor = UIColor(named: "color_gray")?.cgColor
        btnGoogle.layer.borderWidth = 0.5
        btnGoogle.layer.borderColor = UIColor(named: "color_gray")?.cgColor
        
    }
    
    @IBAction func btnConfirmTapped(_ sender: UIButton) {
        
        let email = txtFieldEmail.text!
        let password = txtFieldPassword.text!
        let username = txtFieldUsername.text!
        let phone = txtFieldPhone.text!
        
        let userAuthInfo = UserAuthVO(email: email, password: password, name: username, phone: phone, googleAccessToken: "", facebookAccessToken: "")
        
        if isLoginSelected {
            loginWithEmail(authInfo: userAuthInfo)
        } else {
            signInWithEmail(authInfo: userAuthInfo)
        }
        
        
    }
    
    @IBAction func btnSignInWithGoogleTapped(_ sender: UIButton) {
        
        let email = txtFieldEmail.text!
        let password = txtFieldPassword.text!
        let username = txtFieldUsername.text!
        let phone = txtFieldPhone.text!
        
        
        print("Before response is working")
        googleAuth.start(view: self) { response in
            print("Response is working")
            if self.isLoginSelected {
                self.loginWithGoogle(token: response.id)
            } else {
                if self.validateSignInInputs() {
                    
                    let userAuthInfo = UserAuthVO(email: email, password: password, name: username, phone: phone, googleAccessToken: response.id, facebookAccessToken: "")
                    print("Google sign in working")
                    self.signInWithEmail(authInfo: userAuthInfo)
                    
                }
            }
            print(response)
        } failure: { error in
            print("Error login failed")
            print(error)
        }
        

    }
    
    
    private func loginWithGoogle(token: String) {
        networkAgent.loginWithGoogle(token: token) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.hideErrorView()
                print(data.id)
                self.navigateToHomeViewController()
                
            case .failure(let message):
                self.showErrorMessage(message: message)
            }
        }
    }
    
    
    //MARK: - Email Login
    private func loginWithEmail(authInfo: UserAuthVO) {
        if validateLoginWithEmailInputs(){
            networkAgent.loginWithEmail(userAuthInfo: authInfo) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    self.hideErrorView()
                    print(data.id)
                    self.navigateToHomeViewController()
                    
                case .failure(let message):
                    self.showErrorMessage(message: message)
                }
            }
        }
    }
    
    
    //MARK: - Email Sign In
    private func signInWithEmail(authInfo: UserAuthVO) {
        if validateSignInInputs() {
            networkAgent.signIn(userAuthInfo: authInfo) { result in
                switch result {
                case .success(_):
                    self.hideErrorView()
                    self.navigateToHomeViewController()
                    
                case .failure(let message):
                    self.showErrorMessage(message: message)
                }
            }
        }
    }
    
    private func validateLoginWithEmailInputs() -> Bool {
        if txtFieldEmail.text! == "" && txtFieldPassword.text! == "" {
            print("Email and password is required")
            showErrorMessage(message: "Email and password is required.")
            return false
        } else if txtFieldEmail.text! == "" {
            showErrorMessage(message: "Email is required.")
            return false
        } else if txtFieldPassword.text! == "" {
            showErrorMessage(message: "Password is required.")
            return false
        } else if !isValidEmail(txtFieldEmail.text!) {
            showErrorMessage(message: "Error! Invalid Email.")
            return false
        } else {
            print("All Complete")
            return true
        }
    }
    
    private func validateSignInInputs() -> Bool {
        if txtFieldEmail.text! == "" && txtFieldPassword.text! == "" && txtFieldUsername.text! == "" && txtFieldPhone.text! == "" {
            showErrorMessage(message: "All inputs must be filled.")
            return false
        } else if !validateLoginWithEmailInputs() {
            return false
        } else if txtFieldUsername.text! == "" {
            showErrorMessage(message: "Username is required.")
            return false
        } else if txtFieldPhone.text! == "" {
            showErrorMessage(message: "Phone number is required.")
            return false
        } else {
            print("All Complete")
            
            return true
        }
    }
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func showErrorMessage(message: String) {
        containerError.isHidden = false
        lblError.text = message
    }
    
    
    
    

}
