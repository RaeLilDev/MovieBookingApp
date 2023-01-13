//
//  PaymentViewController.swift
//  MovieBookingApp
//
//  Created by Ye Lynn Htet on 22/02/2022.
//

import UIKit
import UPCarouselFlowLayout


class PaymentViewController: UIViewController {

    @IBOutlet weak var collectionViewBankCard: UICollectionView!
    @IBOutlet weak var lblPaymentAmount: UILabel!
    
    private let paymentMethodModel = PaymentMethodModelImpl.shared
    
    var bookingRecent = BookingRecentVO.shared
    
    var cardList = [CardVO]()
    
    var totalPrice: Int?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        bindData()

        registerCollectionView()
        
        setupCarouselView()
        
        setupNavBar()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchCards()
    }
    
    private func bindData() {
        if let totalPrice = totalPrice {
            lblPaymentAmount.text = "$ \(totalPrice)"
        }
    }
    
    func registerCollectionView() {
        collectionViewBankCard.dataSource = self
        collectionViewBankCard.delegate = self
        collectionViewBankCard.registerForCell(identifier: BankCardCollectionViewCell.identifier)
    }
    
    private func setupNavBar() {
        self.navigationItem.backButtonTitle = ""
    }
    
    func setupCarouselView() {
        let layout = UPCarouselFlowLayout()
        layout.itemSize.width = view.bounds.width * 0.8
        layout.itemSize.height = 180
        layout.scrollDirection = .horizontal
        layout.sideItemAlpha = 0.5
        layout.sideItemScale = 0.8
        layout.spacingMode = .overlap(visibleOffset: view.bounds.width * 0.05)
        collectionViewBankCard.collectionViewLayout = layout
    }
    
    //MARK: - Fetch Cards
    
    private func fetchCards() {
        paymentMethodModel.getCards { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                if data.count == 0 {
                    print("There is no cards.")
                    self.navigateToAddNewCardViewController()
                } else {
                    self.cardList = data
                    self.bookingRecent.cardId = self.cardList[0].id
                    self.collectionViewBankCard.reloadData()
                    
                }
                
            case .failure(let message):
                print(message)
            }
        }
    }
    
    //MARK: - Ontap Callbacks
    
    @IBAction func btnAddNewCardTapped(_ sender: UIButton) {
        navigateToAddNewCardViewController()
    }
    
    
    //MARK: - OnTap Confirm
    @IBAction func btnConfirmTapped(_ sender: UIButton) {
        if self.cardList.count != 0 {
            
            let bookingVO = bookingRecent.toBookingVO()
            
            paymentMethodModel.checkout(booking: bookingVO) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    self.navigateToTicketViewController(checkout: data)
                    
                case .failure(let message):
                    print(message)
                }
            }
        }
    }
    
    
}


//MARK: - CollectionView Datasource
extension PaymentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(identifier: BankCardCollectionViewCell.identifier, indexPath: indexPath) as BankCardCollectionViewCell
        cell.data = cardList[indexPath.row]
        return cell
    }
    
}

//MARK: - CollectionView Delegate
extension PaymentViewController: UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = collectionViewBankCard.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = layout.itemSize.width
        let offset = scrollView.contentOffset.x
        let selectedCardIndex = Int(floor((offset - pageSide / 2) / pageSide) + 1)
        bookingRecent.cardId = cardList[selectedCardIndex].id
    }
    
}
