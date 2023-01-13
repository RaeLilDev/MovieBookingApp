//
//  ViewExtensions.swift
//  MovieBookingApp
//
//  Created by Ye Lynn Htet on 20/02/2022.
//

import Foundation
import UIKit

extension UIViewController {
    static var identifier: String {
        String(describing: self)
    }
}

extension UITableViewCell {
    static var identifier: String {
        String(describing: self)
    }
}

extension UITableView {
    func registerForCell(identifier: String) {
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func dequeueCell<T:UITableViewCell>(identifier: String, indexPath: IndexPath)->T {
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            return UITableViewCell() as! T
        }
        return cell
    }
}

extension UICollectionViewCell {
    static var identifier: String {
        String(describing: self)
    }
}

extension UICollectionView {
    func registerForCell(identifier: String) {
        register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueCell<C:UICollectionViewCell>(identifier: String, indexPath: IndexPath)->C {
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? C else {
            return UICollectionViewCell() as! C
        }
        return cell
    }
}

extension UITextField {
    
    func setUpUnderline() {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor(named: "color_gray")?.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width - 10, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
}

extension UIView {
    
    func dropShadow(color: UIColor, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 16
        layer.cornerRadius = 16
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        
      }
    
    func createDottedLine(width: CGFloat, color: CGColor) {
        
       let caShapeLayer = CAShapeLayer()
       caShapeLayer.strokeColor = color
       caShapeLayer.lineWidth = width
       caShapeLayer.lineDashPattern = [12,12]
       let cgPath = CGMutablePath()
       let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: UIScreen.main.bounds.width-40, y: 0)]
       cgPath.addLines(between: cgPoint)
       caShapeLayer.path = cgPath
       layer.addSublayer(caShapeLayer)
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = 16.0

       layer.insertSublayer(gradientLayer, at: 0)
    }

}


