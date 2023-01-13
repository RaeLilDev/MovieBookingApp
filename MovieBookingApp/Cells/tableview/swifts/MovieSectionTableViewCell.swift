//
//  MovieSectionTableViewCell.swift
//  MovieBookingApp
//
//  Created by Ye linn htet on 4/29/22.
//

import UIKit

class MovieSectionTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionViewNowShowing: UICollectionView!
    @IBOutlet weak var lblSectionHeader: UILabel!
    
    var delegate: MovieItemDelegate?
    
    var data: [MovieVO]? {
        didSet {
            if let _ = data {
                collectionViewNowShowing.reloadData()
            }
        }
    }
    
    var sectionHeader: String? {
        didSet {
            if let data = sectionHeader {
                lblSectionHeader.text = data
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        registerCollectionViewCell()
        
    }
    
    func registerCollectionViewCell() {
        collectionViewNowShowing.dataSource = self
        collectionViewNowShowing.delegate = self
        collectionViewNowShowing.registerForCell(identifier: MovieCollectionViewCell.identifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension MovieSectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(identifier: MovieCollectionViewCell.identifier, indexPath: indexPath) as MovieCollectionViewCell
        cell.data = data?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/2.6, height: 264)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movieId = data?[indexPath.row].id ?? -1
        
        delegate?.onTapMovie(id: movieId)
    }
    
}

