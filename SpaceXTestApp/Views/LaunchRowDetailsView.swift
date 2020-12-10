//
//  LaunchRowDetailsView.swift
//  SpaceXTestApp
//
//  Created by vladikkk on 10/12/2020.
//

import UIKit

class LaunchRowDetailsView: UIView {
    // MARK: - Properties
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = .lightGray
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
        self.addSubview(self.titleLabel)
        self.addSubview(self.dateLabel)
        
        self.setupLayout()
    }
    
    
    // Setup layout constraints
    private func setupLayout() {
        self.setupTitleLabelLayout()
        self.setupDateLabelLayout()
    }
    
    private func setupTitleLabelLayout() {
        NSLayoutConstraint.activate([
            self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            self.titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4)
        ])
    }
    
    private func setupDateLabelLayout() {
        NSLayoutConstraint.activate([
            self.dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.dateLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            self.dateLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4)
        ])
    }
}

extension LaunchRowDetailsView {
    func setupLabelTitles(title: String, date: String) {
        self.setupTitleLabelTitle(withTitle: title)
        
        self.setupDateLabelTitle(withTitle: date)
    }
    
    private func setupTitleLabelTitle(withTitle title: String) {
        DispatchQueue.main.async {
            self.titleLabel.attributedText = NSAttributedString(string: title, attributes: [.foregroundColor : UIColor.cyan, .font : UIFont(name: "Times New Roman", size: 16)!])
        }
    }
    
    private func setupDateLabelTitle(withTitle title: String) {
        DispatchQueue.main.async {
            self.dateLabel.attributedText = NSAttributedString(string: title, attributes: [.foregroundColor : UIColor.white, .font : UIFont(name: "Times New Roman", size: 18)!])
        }
    }
}
