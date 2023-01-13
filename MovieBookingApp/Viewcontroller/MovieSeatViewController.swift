//
//  MovieSeatViewController.swift
//  MovieBookingApp
//
//  Created by Ye Lynn Htet on 13/02/2022.
//

import UIKit
import RxSwift
import RxCocoa

class MovieSeatViewController: UIViewController {

    @IBOutlet weak var collectionViewMovieSeats: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblCinemaName: UILabel!
    @IBOutlet weak var lblMovieDateTime: UILabel!
    @IBOutlet weak var lblTicketCount: UILabel!
    @IBOutlet weak var lblSelectedSeats: UILabel!
    @IBOutlet weak var btnBuyTicket: UIButton!
    
    var viewModel: MovieSeatViewModel!
    var cinemaModel: CinemaModel = CinemaModelImpl.shared
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//
//        viewModel = MovieSeatViewModel()
        viewModel = MovieSeatViewModel(cinemaModel: CinemaModelImpl.shared)
        
        initView()
        
        registerCells()
        
        setUpDataSourceAndDelegates()
        
        bindViewState()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    
    private func initView() {
        
        lblMovieName.text = viewModel.getMovieName()
        lblCinemaName.text = viewModel.getCinemaName()
        let weekDay = viewModel.getWeekDay()
        let dayMonth = viewModel.getDayMonth()
        let time = viewModel.getStartTime()
        lblMovieDateTime.text = "\(weekDay) \(dayMonth), \(time)"
        lblTicketCount.text = "\(viewModel.ticketCount)"
        lblSelectedSeats.text = viewModel.seatNames
        btnBuyTicket.setTitle("Buy Ticket For $\(viewModel.ticketPrice)", for: .normal)
        
    }
    
    //MARK: - BindView State
    private func bindViewState() {
        viewModel.viewState
            .subscribe(onNext: {state in

                switch state {

                case .successFetchingSeats:
                    self.setupCollectionViewHeight()
                    self.collectionViewMovieSeats.reloadData()

                case .updateSelectedUI:
                    self.updateSeatSelectedUI()

                case .goToSnackView(let ticketPrice):
                    self.navigateToSnackViewController(ticketPrice: ticketPrice)

                case .error(_):
                    print("Error occured")

                case .none:
                    print("Nothing")
                }
            }).disposed(by: disposeBag)
    }
    
    
    
    private func setupNavBar() {
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
    }
    
    
    //MARK: - Setup Collectionview
    func registerCells() {
        collectionViewMovieSeats.register(UINib(nibName: String(describing: MovieSeatCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: MovieSeatCollectionViewCell.self))
    }
    
    func setUpDataSourceAndDelegates() {
        
        collectionViewMovieSeats.dataSource = self
        collectionViewMovieSeats.delegate = self
    }
    
    
    func setupCollectionViewHeight() {
        let seatNumberPerRow = viewModel.getSeatNumbersPerRow()
        let totalSeats = viewModel.getSeatCount()
        collectionViewHeight.constant = CGFloat(28 * (totalSeats/seatNumberPerRow))
    }
    
    
    //MARK: - OnTap BuyTicket
    
    @IBAction func btnBuyTicketTapped(_ sender: UIButton) {
        
        viewModel.navigateToSnackViewController()
    }
}


//MARK: - CollectionView DataSource
extension MovieSeatViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getSeatCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieSeatCollectionViewCell.self), for: indexPath) as? MovieSeatCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.bindData(movieSeatVO: viewModel.seatList[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectMovieSeat(index: indexPath.row)
    }

    
    private func updateSeatSelectedUI() {
        lblTicketCount.text = "\(viewModel.ticketCount)"
        lblSelectedSeats.text = "\(viewModel.seatNames)"
        btnBuyTicket.setTitle("Buy Ticket for $\(viewModel.ticketPrice)", for: .normal)
        
        collectionViewMovieSeats.reloadData()
        
    }
    
    
}

//MARK: - CollectionView Delegates
extension MovieSeatViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / CGFloat(viewModel.getSeatNumbersPerRow())
        let height = CGFloat(28)
        return CGSize(width: width, height: height)
    }
    
}

