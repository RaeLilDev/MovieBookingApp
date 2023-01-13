//
//  AddNewCardViewController.swift
//  MovieBookingApp
//
//  Created by Ye Lynn Htet on 23/02/2022.
//

import UIKit

class AddNewCardViewController: UIViewController {

    @IBOutlet weak var txtFieldCardNumber: UITextField!
    @IBOutlet weak var txtFieldCardHolder: UITextField!
    @IBOutlet weak var txtFieldExpirationDate: UITextField!
    @IBOutlet weak var txtFieldCVC: UITextField!
    @IBOutlet weak var viewError: UIStackView!
    @IBOutlet weak var lblErrorMessage: UILabel!
    
    private let paymentMethodModel = PaymentMethodModelImpl.shared
    
    var cardNumber = ""
    var cardHolder = ""
    var expirationDate = ""
    var cvc = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideErrorMessage()
        
        initTextFields()
        
        setupNavBar()
    }
    
    func initTextFields() {
        txtFieldCardNumber.setUpUnderline()
        txtFieldCardHolder.setUpUnderline()
        txtFieldExpirationDate.setUpUnderline()
        txtFieldCVC.setUpUnderline()
    }
    
    private func setupNavBar() {
        self.navigationItem.backButtonTitle = ""
    }
    
    //MARK: - Ontap Confirm
    
    @IBAction func btnConfirmTapped(_ sender: UIButton) {
        
        cardNumber = txtFieldCardNumber.text!
        cardHolder = txtFieldCardHolder.text!
        expirationDate = txtFieldExpirationDate.text!
        cvc = txtFieldCVC.text!
        
        if validateInputs() {
            print("Well Done!")
            let card = CardVO()
            card.cardNumber = cardNumber
            card.cardHolder = cardHolder
            card.expirationDate = expirationDate
            card.cvc = Int(cvc)!
            
            createCard(with: card)
            
        }
        
    }
    
    //MARK: - Create Card
    private func createCard(with card: CardVO) {
        paymentMethodModel.createCard(card: card) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                
                self.navigationController?.popViewController(animated: true)
                
            case .failure(let message):
                print(message)
            }
        }
    }
    
    //MARK: - Validate inputs
    private func validateInputs() -> Bool {
        if cardNumber.isEmpty {
            showErrorMessage(message: "Please fill card number.")
            return false
        } else if cardHolder.isEmpty{
            showErrorMessage(message: "Please fill card holder name.")
            return false
        }else if expirationDate.isEmpty {
            showErrorMessage(message: "Please fill expiration date.")
            return false
        } else if cvc.isEmpty {
            showErrorMessage(message: "Please fill CVC number..")
            return false
        } else if cardNumber.count != 16{
            showErrorMessage(message: "Invalid card number")
            return false
        } else if cvc.count != 3 {
            showErrorMessage(message: "Invalid CVC number.")
            return false
        } else {
            return true
        }
    }
    
    //MARK: - Show & Hide Error
    private func showErrorMessage(message: String) {
        viewError.isHidden = false
        lblErrorMessage.text = message
    }
    
    private func hideErrorMessage() {
        viewError.isHidden = true
    }
}
