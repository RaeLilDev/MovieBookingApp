//
//  MovieDetailViewController.swift
//  MovieBookingApp
//
//  Created by Ye Lynn Htet on 20/02/2022.
//

import UIKit

class MovieDetailViewController: UIViewController {

    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lblRuntime: UILabel!
    @IBOutlet weak var lblIMDB: UILabel!
    @IBOutlet weak var viewRating: RatingControl!
    @IBOutlet weak var lblOverview: UILabel!
    
    @IBOutlet weak var containerBottomOverlap: UIView!
    @IBOutlet weak var collectionViewGenre: UICollectionView!
    @IBOutlet weak var collectionViewCast: UICollectionView!
    
    var genreList = [String]()
    var castList = [CastVO]()
    
    private let movieModel = MovieModelImpl.shared
    var bookingRecent = BookingRecentVO.shared
    
    var movieId = 0
    var movieName = ""
    var posterPath = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCollectionViewCells()
        
        initBottomOverlapView()
        
        fetchMovieDetail()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
    }
    
    
    //MARK: - Register CollectionView Cells
    func registerCollectionViewCells() {
        collectionViewGenre.dataSource = self
        collectionViewGenre.delegate = self
        collectionViewGenre.registerForCell(identifier: GenreCollectionViewCell.identifier)
        collectionViewCast.dataSource = self
        collectionViewCast.delegate = self
        collectionViewCast.registerForCell(identifier: CastCollectionViewCell.identifier)
    }
    
    //MARK: - InitView
    func initBottomOverlapView() {
        containerBottomOverlap.layer.cornerRadius = 32
        containerBottomOverlap.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setupNavBar() {
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    //MARK: - Network Calls
    private func fetchMovieDetail() {
        movieModel.getMovieDetail(id: movieId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.bindData(data: data)
                
            case .failure(let message):
                print(message)
            }
        }
    }
    
    
    private func bindData(data: MovieVO) {
        lblTitle.text = data.originalTitle
        lblIMDB.text = "\(data.rating)"
        lblOverview.text = data.overview
        
        let runTimeHour = Int(data.runtime / 60)
        let runTimeMinutes = data.runtime % 60
        bookingRecent.duration = data.runtime
        
        
        lblRuntime.text = "\(runTimeHour) h \(runTimeMinutes) m"
        
        viewRating.rating = Int(data.rating * 0.5)
        
        posterPath = "\(AppConstants.baseImageURL)/\(data.posterPath)"
        let url = posterPath
        ivPoster.sd_setImage(with: URL(string: url)!)
        
        genreList = data.genres.map { $0 }
        castList = data.casts.map { $0 }
        
        movieName = data.originalTitle
        
        collectionViewGenre.reloadData()
        collectionViewCast.reloadData()
        
    }
    
    
    
    //MARK: - Ontap Callbacks
    
    @IBAction func btnGetTicketTapped(_ sender: UIButton) {
        bookingRecent.movieId = movieId
        bookingRecent.movieName = movieName
        bookingRecent.posterPath = posterPath
        navigateToMovieTimeViewController()
        
    }
    
    
}


//MARK: - CollView DataSource & Delegates
extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewGenre {
            return genreList.count
        } else {
            return castList.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewGenre {
            let cell = collectionView.dequeueCell(identifier: GenreCollectionViewCell.identifier, indexPath: indexPath) as GenreCollectionViewCell
            cell.bindData(with: genreList[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueCell(identifier: CastCollectionViewCell.identifier, indexPath: indexPath) as CastCollectionViewCell
            cell.data = castList[indexPath.row]
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewGenre {
            return CGSize(width: widthOfString(text: genreList[indexPath.row], font: UIFont.systemFont(ofSize: 14.0))+40, height: 40)
        } else {
            return CGSize(width: 80, height: 80)
        }
        
    }
    
    func widthOfString(text: String, font: UIFont) ->CGFloat {
        
        let fontAttributes = [NSAttributedString.Key.font: font]
        let textSize = text.size(withAttributes: fontAttributes)
        
        return CGFloat(textSize.width)
    }
    
    
}
