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
    private var launchDetails: LaunchData?
    
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
    
    lazy var imageViewFrame: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 0.7
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.backgroundColor = .clear
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
        self.addSubview(self.imageViewFrame)
        self.addSubview(self.imageView)
        self.addSubview(self.detailsView)
        self.addSubview(self.button)
        
        self.setupDelimiterViewLayout()
        self.setupButtonLayout()
        self.setupImageViewFrameLayout()
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
    
    private func setupImageViewFrameLayout() {
        NSLayoutConstraint.activate([
            self.imageViewFrame.topAnchor.constraint(equalTo: self.delimiterView.bottomAnchor, constant: 2),
            self.imageViewFrame.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.imageViewFrame.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.imageViewFrame.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75)
        ])
    }
    
    private func setupImageViewLayout() {
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.imageViewFrame.topAnchor, constant: 1),
            self.imageView.bottomAnchor.constraint(equalTo: self.imageViewFrame.bottomAnchor, constant: -1),
            self.imageView.leadingAnchor.constraint(equalTo: self.imageViewFrame.leadingAnchor, constant: 1),
            self.imageView.trailingAnchor.constraint(equalTo: self.imageViewFrame.trailingAnchor, constant: -1)
        ])
    }
    
    private func setupDetailsViewLayout() {
        NSLayoutConstraint.activate([
            self.detailsView.topAnchor.constraint(equalTo: self.imageViewFrame.bottomAnchor, constant: 5),
            self.detailsView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            self.detailsView.leadingAnchor.constraint(equalTo: self.imageViewFrame.leadingAnchor),
            self.detailsView.trailingAnchor.constraint(equalTo: self.imageViewFrame.trailingAnchor)
        ])
    }
}

// Setup Cell Data
extension LaunchCell {
    func setupCellData(withData cellData: LaunchData) {
        self.launchDetails = cellData
        
        if let largeImageLink = cellData.patchData?.large {
            self.setupImageView(from: largeImageLink)
        }
        
        self.detailsView.setupLabelTitles(title: cellData.name!, date: cellData.date!)
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
