//
//  ViewController.swift
//  SpaceXTestApp
//
//  Created by vladikkk on 10/12/2020.
//

import UIKit

class LaunchListVC: UIViewController {
    // MARK: Properties
    private var launches = [LaunchData]()
    
    // Create a collection view with vertical scroll and custom layout config
    lazy var launchesView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        view.isPagingEnabled = false
        view.isScrollEnabled = true
        return view
    }()
    
    // MARK: Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Load data before view will appear
        
        let launchesWS = LaunchesWebService()
        
        DispatchQueue.global(qos: .background).async {
            launchesWS.getLaunches { (resp) in
                if let launches = resp {
                    DispatchQueue.main.async {
                        // Store data
                        self.launches = [launches]
                        
                        // Reload collection view
                        self.launchesView.reloadData()
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        
        // Setup collection view to receive data and touches
        self.launchesView.delegate = self
        self.launchesView.dataSource = self
        
        // Register cell
        self.launchesView.register(LaunchCell.self, forCellWithReuseIdentifier: LaunchCell.cellID)
        
        // Add collection view to super view
        self.view.addSubview(self.launchesView)
        
        // Setup layput constraints
        self.setupLayout()
    }
}

// Setup layout constraints
extension LaunchListVC {
    private func setupLayout() {
        self.setupLaunchesViewLayout()
    }
    
    private func setupLaunchesViewLayout() {
        NSLayoutConstraint.activate([
            self.launchesView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.launchesView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.launchesView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            self.launchesView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
    }
}

// Launches Collection View Setup
extension LaunchListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.launches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchCell.cellID, for: indexPath) as? LaunchCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.row <= self.launches.count {
            cell.setupCellData(withData: self.launches[indexPath.row])
        }
        
        DispatchQueue.main.async {
            cell.backgroundColor = .darkGray
        }
        
        return cell
    }
}

// Launches Flow Layout Setup
extension LaunchListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Setup cell size
        let size = self.launchesView.frame.size
        return CGSize(width: size.width, height: size.height * 0.25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
