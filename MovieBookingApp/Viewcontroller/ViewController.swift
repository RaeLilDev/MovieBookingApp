//
//  ViewController.swift
//  MovieBookingApp
//
//  Created by Ye Lynn Htet on 13/02/2022.
//

import UIKit

class ViewController: UIViewController, MovieItemDelegate {

    @IBOutlet weak var tableViewMovies: UITableView!
    
    private let authModel: AuthenticationModel = AuthenticationModelImpl.shared
    private let movieModel: MovieModel = MovieModelImpl.shared
    
    var userProfileInfo: ProfileVO?
    
    var nowShowingMovies = [MovieVO]()
    var upcomingMovies = [MovieVO]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableViewCells()
        
        fetchProfileInfo()
        
        fetchNowShowingMovies()
        
        fetchUpcomingMovies()
        
        setupNavBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
    }
    
    private func registerTableViewCells() {
        tableViewMovies.dataSource = self
        tableViewMovies.delegate = self
        tableViewMovies.registerForCell(identifier: WelcomeMessageTableViewCell.identifier)
        tableViewMovies.registerForCell(identifier: MovieSectionTableViewCell.identifier)
    }
    
    private func setupNavBar() {
        self.navigationItem.backButtonTitle = ""
        self.navigationItem.rightBarButtonItem?.accessibilityIdentifier = "search_button"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    
    //MARK: - Ontap Callbacks
    func onTapMovie(id: Int) {
        
        navigateToMovieDetailViewController(movieId: id)
        
    }
    
    //MARK: - Network Calls

    private func fetchProfileInfo() {
        authModel.getUserProfileInfo { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.userProfileInfo = data
                self.tableViewMovies.reloadData()
                
            case .failure(let message):
                print(message)
            }
            
        }
    }
    
    private func fetchNowShowingMovies() {
        movieModel.getNowShowingMovieList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.nowShowingMovies = data
                self.tableViewMovies.reloadData()
                
            case .failure(let message):
                print(message)
            }
        }
    }
    
    private func fetchUpcomingMovies() {
        movieModel.getComingSoonMovieList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.upcomingMovies = data
                self.tableViewMovies.reloadData()
                
            case .failure(let message):
                print(message)
            }
        }
    }
    
    
}

//MARK: - tableview datasource & Delegates
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueCell(identifier: WelcomeMessageTableViewCell.identifier, indexPath: indexPath) as WelcomeMessageTableViewCell
            cell.data = userProfileInfo
            return cell
            
        case 1:
            let cell = tableView.dequeueCell(identifier: MovieSectionTableViewCell.identifier, indexPath: indexPath) as MovieSectionTableViewCell
            cell.delegate = self
            cell.data = nowShowingMovies
            cell.sectionHeader = "Now Showing"
            return cell
            
        case 2:
            let cell = tableView.dequeueCell(identifier: MovieSectionTableViewCell.identifier, indexPath: indexPath) as MovieSectionTableViewCell
            cell.delegate = self
            cell.data = upcomingMovies
            cell.sectionHeader = "Coming Soon"
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    
}

