//
//  MovieTimeViewController.swift
//  MovieBookingApp
//
//  Created by Ye Lynn Htet on 13/02/2022.
//

import UIKit

class MovieTimeViewController: UIViewController {
    
    //Views
    @IBOutlet weak var viewContainerTimes: UIView!
    @IBOutlet weak var collectionViewDays: UICollectionView!
    @IBOutlet weak var collectionViewAvailableIn: UICollectionView!
    @IBOutlet weak var collectionViewTimeSlots: UICollectionView!
    
    //Constraints
    @IBOutlet weak var collectionViewHeightAvailableIn: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeightTimeSlots: NSLayoutConstraint!
    
    var cinemaModel: CinemaModel = CinemaModelImpl.shared
    var bookingRecent = BookingRecentVO.shared
    
    var dayList = [DateVO]()
    var cinemaList = [CinemaVO]()
    var cinemaDayTimeSlotList = [CinemaDayTimeSlotVO]()
    
    var selectedCinemaId = 0
    var selectedCinemaName = ""
    var selectedTimeSlotId = 0
    var selectedTime = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        
        fetchCinemaList()
        
        //fetchCinemaDayTimeSlots(date: dayList.first!.date, movieId: "7669076")
        fetchCinemaDayTimeSlots(date: dayList.first!.date, movieId: "\(bookingRecent.movieId ?? 0)")
        
    }
    
    
    //MARK: - init view
    private func initView() {
        
        setupViewContaienrTimes()
        
        registerCells()
        
        setupDatasourceAndDelegate()
        
        setupDayList()
        
        setUpHeightForCollectionView()
        
        setDefaultSelectedDate(selectedDate: dayList.first!)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
    }
    
    
    private func setupViewContaienrTimes() {
        viewContainerTimes.layer.cornerRadius = 16
        viewContainerTimes.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    
    private func registerCells() {
        collectionViewDays.register(UINib(nibName: String(describing: DaysCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: DaysCollectionViewCell.self))
        collectionViewAvailableIn.register(UINib(nibName: String(describing: TimesCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: TimesCollectionViewCell.self))
        
        collectionViewTimeSlots.register(UINib(nibName: String(describing: TimesCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: TimesCollectionViewCell.self))
    }
    
    
    private func setupNavBar() {
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    
    //MARK: - Setup Datasource & Delegates
    private func setupDatasourceAndDelegate() {
        collectionViewDays.dataSource = self
        collectionViewDays.delegate = self
        
        collectionViewAvailableIn.dataSource = self
        collectionViewAvailableIn.delegate = self
        
        collectionViewTimeSlots.dataSource = self
        collectionViewTimeSlots.delegate = self
        
    }
    
    //MARK: - Setup CollectionView Height
    private func setUpHeightForCollectionView() {
        collectionViewHeightAvailableIn.constant = 56
        collectionViewHeightTimeSlots.constant = CGFloat((56 + 60) * cinemaDayTimeSlotList.count)
        self.view.layoutIfNeeded()
    }
    
    //MARK: - Setup Daylist
    private func setupDayList() {
        dayList = Date().getTenDaysFromNow()
        dayList.first?.isSelected = true
        collectionViewDays.reloadData()
    }
    
    private func setDefaultSelectedDate(selectedDate: DateVO) {
        bookingRecent.date = selectedDate.date
        bookingRecent.weekDay = selectedDate.weekDay
        bookingRecent.dayMonth = selectedDate.dayMonth
        bookingRecent.time = selectedDate.time
    }
    
    //MARK: - Network Calls
    
    private func fetchCinemaList() {
        cinemaModel.getCinemaList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.cinemaList = data
                self.collectionViewAvailableIn.reloadData()
                
            case .failure(let message):
                print(message)
            }
        }
    }
    
    private func fetchCinemaDayTimeSlots(date: String, movieId: String) {
        cinemaModel.getCinemaDayTimeSlots(date: date, movieId: movieId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.cinemaDayTimeSlotList = data
                self.collectionViewTimeSlots.reloadData()
                self.setUpHeightForCollectionView()
            case .failure(let message):
                print(message)
            }
        }
    }
    
    //MARK: - onTap Callbacks
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnNextTapped(_ sender: UIButton) {
        if selectedCinemaId != 0 && selectedTimeSlotId != 0 {
            bookingRecent.timeSlotId = selectedTimeSlotId
            bookingRecent.startTime = selectedTime
            bookingRecent.cinemaId = selectedCinemaId
            bookingRecent.cinemaName = selectedCinemaName
            
            navigateToMovieSeatViewController()
        }
    }
    
    
}


//MARK: - CollectionView Datasource
extension MovieTimeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if (collectionView == collectionViewTimeSlots) {
            return cinemaDayTimeSlotList.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == collectionViewDays) {
            return dayList.count
        } else if (collectionView == collectionViewAvailableIn) {
            return cinemaList.count
        } else {
            return cinemaDayTimeSlotList[section].timeslots.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == collectionViewDays) {
            let cell = collectionViewDays.dequeueCell(identifier: DaysCollectionViewCell.identifier, indexPath: indexPath) as DaysCollectionViewCell
            cell.data = dayList[indexPath.row]
            cell.onTapDays = { day in
                self.onTapDay(day: day)
            }
            return cell
        } else if (collectionView == collectionViewAvailableIn) {
            let cell = collectionViewAvailableIn.dequeueCell(identifier: TimesCollectionViewCell.identifier, indexPath: indexPath) as TimesCollectionViewCell
            cell.data = cinemaList[indexPath.row].name
            return cell
        } else {
            let cell = collectionViewTimeSlots.dequeueCell(identifier: TimesCollectionViewCell.identifier, indexPath: indexPath) as TimesCollectionViewCell
            cell.data = cinemaDayTimeSlotList[indexPath.section].timeslots[indexPath.row].startTime
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: String(describing: TimeSlotsHeaderView.self),
            for: indexPath
        ) as! TimeSlotsHeaderView
        headerView.lblCinema.text = cinemaDayTimeSlotList[indexPath.section].cinemaName
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == collectionViewAvailableIn) {
            onTapCinema(cinema: cinemaList[indexPath.row])
        } else {
            let timeSlot = cinemaDayTimeSlotList[indexPath.section].timeslots[indexPath.row]
            onTapTimeSlot(timeSlot: timeSlot)
        }
    }
    
    //MARK: - Ontap Day
    private func onTapDay(day: String) {
        dayList.forEach {
            if $0.date == day {
                $0.isSelected = true
                setDefaultSelectedDate(selectedDate: $0)
            } else {
                $0.isSelected = false
            }
        }
        fetchCinemaDayTimeSlots(date: day, movieId: "\(bookingRecent.movieId ?? 0)")
        collectionViewDays.reloadData()
    }
    
    //MARK: - Ontap Cinema
    private func onTapCinema(cinema: CinemaVO) {
        selectedCinemaId = cinema.id
        selectedCinemaName = cinema.name
    }
    
    //MARK: - Ontap Timeslot
    private func onTapTimeSlot(timeSlot: TimeSlotVO) {
        
        selectedTimeSlotId = timeSlot.id
        selectedTime = timeSlot.startTime
    }
    
}


//MARK: - Collectionview Delegates

extension MovieTimeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewDays {
            return CGSize(width: 60, height: 80)
        } else {
            let width = collectionView.bounds.width / 3
            let height = CGFloat(48)
            return CGSize(width: width, height: height)
        }
    }
    
    
}
