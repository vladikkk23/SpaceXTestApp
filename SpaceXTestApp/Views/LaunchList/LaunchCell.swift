//
//  LaunchCell.swift
//  SpaceXTestApp
//
//  Created by vladikkk on 10/12/2020.
//

import UIKit

class LaunchCell: UICollectionViewCell {
    // MARK: Properties
    static let cellID = "LaunchCell"
    private var launchDetails: LaunchDataResponse?
    
    // UI
    lazy var button: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(self.openLaunchDetails), for: .touchUpInside)
        return btn
    }()
    
    lazy var delimiterView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.backgroundColor = .clear
        imgView.layer.borderWidth = 0.7
        imgView.layer.cornerRadius = 10
        imgView.layer.borderColor = UIColor.white.cgColor
        return imgView
    }()
    
    lazy var detailsView: LaunchRowDetailsView = {
        let view = LaunchRowDetailsView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupCell()
    }
    
    // MARK: Methods
    private func setupCell() {
        self.addSubview(self.delimiterView)
        self.addSubview(self.imageView)
        self.addSubview(self.detailsView)
        self.addSubview(self.button)
        
        self.setupDelimiterViewLayout()
        self.setupButtonLayout()
        self.setupImageViewLayout()
        self.setupDetailsViewLayout()
    }
    
    private func setupButtonLayout() {
        NSLayoutConstraint.activate([
            self.button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.button.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.button.heightAnchor.constraint(equalTo: self.heightAnchor),
            self.button.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    private func setupDelimiterViewLayout() {
        NSLayoutConstraint.activate([
            self.delimiterView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.delimiterView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.delimiterView.heightAnchor.constraint(equalToConstant: 1),
            self.delimiterView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.925)
        ])
    }
    
    private func setupImageViewLayout() {
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.delimiterView.bottomAnchor, constant: 2),
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75)
        ])
    }
    
    private func setupDetailsViewLayout() {
        NSLayoutConstraint.activate([
            self.detailsView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 5),
            self.detailsView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            self.detailsView.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor),
            self.detailsView.trailingAnchor.constraint(equalTo: self.imageView.trailingAnchor)
        ])
    }
}

// Setup Cell Data
extension LaunchCell {
    func setupCellData(withData cellData: LaunchDataResponse) {
        self.launchDetails = cellData
        
        // Check if there are any images from flickr, if not then download image from patch
        if let originalImageLink = cellData.links.flickr.original.first, !originalImageLink.isEmpty {
            self.setupImageView(from: originalImageLink)
        } else if let smallImageLink = cellData.links.flickr.small.first, !smallImageLink.isEmpty {
            self.setupImageView(from: smallImageLink)
        } else {
            if let largeImageLink = cellData.links.patch.large {
                self.setupImageView(from: largeImageLink)
            }
        }
        
        self.detailsView.setupLabelTitles(title: cellData.name, date: cellData.date.description)
    }
    
    // Setup and cache image
    fileprivate func setupImageView(from urlString: String) {
        guard let imageUrl = URL(string: urlString) else {
            NSLog("Error: Invalid image link, \(#function)")
            
            return
        }
        
        self.imageView.loadImage(withUrl: imageUrl)
    }
}


// Adding Buttons Functionality
extension LaunchCell {
    @objc private func openLaunchDetails() {
        DispatchQueue.main.async {
            guard let vc = self.findViewController() else { return }
            
            let newVC = LaunchDetailsVC()
            newVC.launchDetails = self.launchDetails
            
            vc.navigationController?.pushViewController(newVC, animated: true)
        }
    }
}
