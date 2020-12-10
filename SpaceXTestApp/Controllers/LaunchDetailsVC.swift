//
//  LaunchDetailsVC.swift
//  SpaceXTestApp
//
//  Created by vladikkk on 10/12/2020.
//

import UIKit

class LaunchDetailsVC: UIViewController {
    // MARK: Properties
    var launchDetails: LaunchData?
    
    // UI
    lazy var playerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemRed
        return view
    }()
    
    lazy var detailsView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        return view
    }()
    
    // MARK: Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let details = self.launchDetails {
            // Setup nav bar title
            self.title = details.name
            
            // Setup labels, description and video player
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
    }
}

// Setup layout constraints
extension LaunchDetailsVC {
    private func setupLayout() {
        self.setupLaunchesViewLayout()
    }
    
    private func setupLaunchesViewLayout() {
        NSLayoutConstraint.activate([
            self.playerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.playerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.playerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4),
            self.playerView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
    }
    
//    private func setupDetailsViewLayout() {
//        NSLayoutConstraint.activate([
//            self.detailsView.
//        ])
//    }
}
