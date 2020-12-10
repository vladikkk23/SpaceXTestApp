//
//  LaunchDetailsView.swift
//  SpaceXTestApp
//
//  Created by vladikkk on 10/12/2020.
//

import UIKit

class LaunchDetailsView: UIView {
    // MARK: - Properties
    lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        return textView
    }()
    
    lazy var rocketNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var payloadsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var linkLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupView()
    }
    
    // MARK: Methods
    private func setupView() {
        self.addSubview(self.dateLabel)
        self.addSubview(self.rocketNameLabel)
        self.addSubview(self.payloadsLabel)
        self.addSubview(self.linkLabel)
        self.addSubview(self.descriptionTextView)
        
        self.setupLayout()
    }
    
    
    // Setup layout constraints
    private func setupLayout() {
        self.setupDateLabelLayout()
        self.setupRocketNameLabelLayout()
        self.setupPayloadsLabelLayout()
        self.setupLinkLabelLayout()
        self.setupDescriptionTextViewLayout()
    }
    
    private func setupDateLabelLayout() {
        NSLayoutConstraint.activate([
            self.dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.dateLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.dateLabel.heightAnchor.constraint(equalToConstant: 30),
            self.dateLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6)
        ])
    }
    
    private func setupRocketNameLabelLayout() {
        NSLayoutConstraint.activate([
            self.rocketNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.rocketNameLabel.bottomAnchor.constraint(equalTo: self.payloadsLabel.topAnchor, constant: -5),
            self.rocketNameLabel.heightAnchor.constraint(equalToConstant: 30),
            self.rocketNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6)
        ])
    }
    
    private func setupPayloadsLabelLayout() {
        NSLayoutConstraint.activate([
            self.payloadsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.payloadsLabel.bottomAnchor.constraint(equalTo: self.linkLabel.topAnchor, constant: -20),
            self.payloadsLabel.heightAnchor.constraint(equalToConstant: 30),
            self.payloadsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6)
        ])
    }
    
    private func setupLinkLabelLayout() {
        NSLayoutConstraint.activate([
            self.linkLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.linkLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.linkLabel.heightAnchor.constraint(equalToConstant: 30),
            self.linkLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6)
        ])
    }
    
    private func setupDescriptionTextViewLayout() {
        NSLayoutConstraint.activate([
            self.descriptionTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.descriptionTextView.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 10),
            self.descriptionTextView.bottomAnchor.constraint(equalTo: self.rocketNameLabel.topAnchor, constant: -10),
            self.descriptionTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
        ])
    }
}

// Open Link
extension LaunchDetailsView: UITextFieldDelegate {
    func setupLabelTitle() {
        // Tap gesture recognizers
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.openLink))

        // Gesture recognizer Label
        self.linkLabel.isUserInteractionEnabled = true
        self.linkLabel.addGestureRecognizer(tap)
        
        DispatchQueue.main.async {
            self.linkLabel.attributedText = NSAttributedString(string: "Wikipedia", attributes: [.foregroundColor : UIColor.blue, .font : UIFont(name: "Times New Roman", size: 18)!])
        }
    }
    
    @objc private func openLink() {
        guard let vc = self.findViewController() as? LaunchDetailsVC else { return }
        
        if let stringURL = vc.launchDetails?.wikipediaLink {
            guard let url = URL(string: stringURL) else { return }
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}

// Setup labels
extension LaunchDetailsView {
    func setupDateLabelTitle(withTitle title: String) {
        DispatchQueue.main.async {
            self.dateLabel.attributedText = NSAttributedString(string: title, attributes: [.foregroundColor : UIColor.white, .font : UIFont(name: "Times New Roman", size: 16)!])
        }
    }
    
    func setupDescriptionTextView(withTitle title: String) {
        DispatchQueue.main.async {
            self.descriptionTextView.attributedText = NSAttributedString(string: title, attributes: [.foregroundColor : UIColor.white, .font : UIFont(name: "Times New Roman", size: 16)!])
        }
    }
    
    func setupRocketNameLabelTitle(withTitle title: String) {
        DispatchQueue.main.async {
            self.rocketNameLabel.attributedText = NSAttributedString(string: "Rocket name: \(title)", attributes: [.foregroundColor : UIColor.cyan, .font : UIFont(name: "Times New Roman", size: 16)!])
        }
    }
    
    func setupPayloadsLabelTitle(withTitle title: String) {
        DispatchQueue.main.async {
            self.payloadsLabel.attributedText = NSAttributedString(string: "Payload: \(title)", attributes: [.foregroundColor : UIColor.cyan, .font : UIFont(name: "Times New Roman", size: 16)!])
        }
    }
}
