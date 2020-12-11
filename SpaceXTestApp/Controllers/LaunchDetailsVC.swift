//
//  LaunchDetailsVC.swift
//  SpaceXTestApp
//
//  Created by vladikkk on 10/12/2020.
//

import UIKit
import WebKit
import AVFoundation

class LaunchDetailsVC: UIViewController {
    // MARK: Properties
    var launchDetails: LaunchDataResponse?
    
    // UI
    lazy var playerView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        let view = WKWebView(frame: .zero, configuration: webConfiguration)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private var playerLayer = AVPlayerLayer()
    
    lazy var detailsView: LaunchDetailsView = {
        let view = LaunchDetailsView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        return view
    }()
    
    // MARK: Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let details = self.launchDetails {
            // Setup nav bar title
            self.title = details.name
            
            // Setup labels, description and video player
            self.detailsView.setupLabelTitle()
            self.detailsView.setupDateLabelTitle(withTitle: details.date.description)
            self.detailsView.setupDescriptionTextView(withTitle: details.desc ?? "No Description")
            self.detailsView.setupRocketNameLabelTitle(withTitle: details.rocketName)
            self.detailsView.setupPayloadsLabelTitle(withTitle: details.payloads.first ?? "No payloads")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        
        // Add views to superview
        self.view.addSubview(self.playerView)
        self.view.addSubview(self.detailsView)
        
        // Setup layout constraints
        self.setupLayout()
        
        // Load video
        if let urlLink = self.launchDetails?.links.youtubeId {
            self.playWebVideo(urlString: urlLink)
        }
    }
}

// Setup layout constraints
extension LaunchDetailsVC {
    private func setupLayout() {
        self.setupLaunchesViewLayout()
        self.setupDetailsViewLayout()
    }
    
    private func setupLaunchesViewLayout() {
        NSLayoutConstraint.activate([
            self.playerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.playerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.playerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3),
            self.playerView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
    }
    
    private func setupDetailsViewLayout() {
        NSLayoutConstraint.activate([
            self.detailsView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.detailsView.topAnchor.constraint(equalTo: self.playerView.bottomAnchor, constant: 30),
            self.detailsView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.detailsView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
    }
}

// Setup video player
extension LaunchDetailsVC {
    func playWebVideo(urlString: String) {
        guard let videoURL = URL(string: urlString) else {
            NSLog("Failed to create url: \(#line)")

            return
        }

        let request = URLRequest(url: videoURL)
        self.playerView.load(request)
    }
}
