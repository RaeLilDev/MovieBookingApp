//
//  SnackViewController.swift
//  MovieBookingApp
//
//  Created by Ye Lynn Htet on 21/02/2022.
//

import UIKit

class SnackViewController: UIViewController {

    @IBOutlet weak var txtFieldPromoCode: UITextField!
    @IBOutlet weak var tableViewCombo: UITableView!
    @IBOutlet weak var tableViewPaymentMethod: UITableView!
    @IBOutlet weak var tableViewHeightCombo: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeightPaymentMethod: NSLayoutConstraint!
    
    @IBOutlet weak var lblSubtotal: UILabel!
    @IBOutlet weak var btnPay: UIButton!
    
    var snackList = [SnackVO]()
    var paymentMethodList = [PaymentMethodVO]()
    
    var snackDictionary = [Int: Int]()
    
    var bookingRecent = BookingRecentVO.shared
    var snackModel = SnackModelImpl.shared
    var paymentModel = PaymentMethodModelImpl.shared
    
    var ticketPrice = 0
    var totalPrice = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
        registerTableViewCells()
        
        txtFieldPromoCode.setUpUnderline()
        
        setupNavBar()
        
        fetchSnackList()
        
        fetchPaymentMethodList()
        
    }
    
    private func initView() {
        lblSubtotal.text = "Sub total: \(ticketPrice)$"
        btnPay.setTitle("Pay $\(ticketPrice)", for: .normal)
    }
    
    func registerTableViewCells() {
        tableViewCombo.dataSource = self
        tableViewCombo.delegate = self
        tableViewCombo.registerForCell(identifier: ComboTableViewCell.identifier)
        tableViewPaymentMethod.dataSource = self
        tableViewPaymentMethod.delegate = self
        tableViewPaymentMethod.registerForCell(identifier: PaymentMethodTableViewCell.identifier)
    }
    
    private func setupNavBar() {
        self.navigationItem.backButtonTitle = ""
    }
    
    private func setupHeightForTableViewCombo(count: Int) {
        tableViewHeightCombo.constant = 86 * CGFloat(count)
    }
    
    private func setupHeightForTableViewPaymentMethods(count: Int) {
        tableViewHeightPaymentMethod.constant = 60 * CGFloat(count)
    }
    
    //MARK: - Network Calls
    
    private func fetchSnackList() {
        snackModel.getSnacks { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.snackList = data
                self.setupHeightForTableViewCombo(count: self.snackList.count)
                self.tableViewCombo.reloadData()
                
            case .failure(let message):
                print(message)
            }
        }
    }
    
    
    private func fetchPaymentMethodList() {
        paymentModel.getPaymentMethods { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.paymentMethodList = data
                self.setupHeightForTableViewPaymentMethods(count: self.paymentMethodList.count)
                self.tableViewPaymentMethod.reloadData()
                
            case .failure(let message):
                print(message)
            }
        }
    }
    
    
    //MARK: - onTap Pay
    
    @IBAction func btnPayTapped(_ sender: UIButton) {
        
        snackDictionary.forEach {
            let snack = [
                "id": $0.key,
                "quantity": $0.value
            ]
            bookingRecent.snacks.append(snack)
        }
        
        bookingRecent.price = totalPrice
        
        navigateToPaymentViewController(totalPrice: totalPrice)
        
    }
    
    
}


//MARK: - TableView DataSource & Delegates
extension SnackViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewCombo {
            return snackList.count
        } else {
            return paymentMethodList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewCombo {
            let cell = tableView.dequeueCell(identifier: ComboTableViewCell.identifier, indexPath: indexPath) as ComboTableViewCell
            cell.data = snackList[indexPath.row]
            cell.updateTotalPrice = {
                
                self.updateUIWithSnackPrice()
                
                self.updateSnackDictionary(index: indexPath.row)
            }
            return cell
        } else {
            let cell = tableView.dequeueCell(identifier: PaymentMethodTableViewCell.identifier, indexPath: indexPath) as PaymentMethodTableViewCell
            cell.data = paymentMethodList[indexPath.row]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableViewCombo {
            return CGFloat(86)
        } else {
            return CGFloat(60)
        }
        
    }
    
    //MARK: - Snack Total Price
    private func getSnackTotalPrice() -> Int {
        var snackTotal = 0
        snackList.forEach {
            snackTotal += $0.price * $0.count
        }
        
        return snackTotal
    }
    
    //MARK: - Update UI
    private func updateUIWithSnackPrice() {
        
        totalPrice = ticketPrice + getSnackTotalPrice()
        lblSubtotal.text = "Sub total: \(totalPrice) $"
        btnPay.setTitle("Pay $\(totalPrice)", for: .normal)
        
    }
    
    private func updateSnackDictionary(index: Int) {
        snackDictionary[snackList[index].id] = snackList[index].count
    }
    
    
}
