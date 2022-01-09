//
//  RememberHeaderView.swift
//  Photation
//
//  Created by Gleb Uvarkin on 18.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class RememberHeaderView: UIView {
    //    MARK: - Properties
    
    private let wordLabel = UILabel()
    
    //    MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addAndConfigureWordLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - UI configuration
    
    private func addAndConfigureWordLabel() {
        wordLabel.numberOfLines = 1
        wordLabel.textColor = .black
        wordLabel.textAlignment = .center
        wordLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        wordLabel.layer.cornerRadius = 10
        wordLabel.clipsToBounds = true
        wordLabel.backgroundColor = #colorLiteral(red: 0.9371728301, green: 0.9373074174, blue: 0.9371433854, alpha: 1)
        
        wordLabel.layer.borderWidth = 2
        wordLabel.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        addSubview(wordLabel)
        
        NSLayoutConstraint.activate([
            wordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            wordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            wordLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            wordLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
    //    MARK: - UI update
    
    func update(with text: String?) {
        wordLabel.text = text
    }
    
}
