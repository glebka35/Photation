//
//  NavigationBar.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 07.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

protocol NavigationBarDelegate: class {
    func rightAction(sender: UIButton!)
}

class NavigationBar: UIView {
    
    weak var delegate: NavigationBarDelegate?
    
    public var titleString: String? {
        didSet { title.text = titleString }
    }
    
    public var rightTitleString: String? {
        didSet { rightTitle.text = rightTitleString }
    }
    
    public var rightButtonImage: UIImage? {
        didSet { rightButton.setImage(rightButtonImage, for: .normal) }
    }
    
    private let title = UILabel()
    private let rightTitle = UILabel()
    private let rightButton = UIButton()
    private let searchBar = UISearchBar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addAndConfigureTitle()
        addAndConfigureRightTitle()
        addAndConfigureRightButton()
        
        embedInStackView()
        
        addAndConfigureSearchBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addAndConfigureTitle() {
        addSubview(title)
        
        title.numberOfLines = 1
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 34, weight: .bold)
    }
    
    private func addAndConfigureRightTitle() {
        addSubview(rightTitle)
        
        rightTitle.numberOfLines = 1
        rightTitle.textAlignment = .center
        rightTitle.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        rightTitle.textColor = UIColor(displayP3Red: 104/255, green: 105/255, blue: 105/255, alpha: 1)
    }
    
    private func addAndConfigureRightButton() {
        addSubview(rightButton)
        
        rightButton.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
    }
    
    @objc func rightButtonAction(sender: UIButton!) {
        delegate?.rightAction(sender: sender)
    }
    
    private func addAndConfigureSearchBar() {
        searchBar.backgroundImage = UIImage()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func embedInStackView() {
        let hStack = UIStackView(arrangedSubviews: [title, rightTitle, rightButton])
        
        hStack.distribution = .equalSpacing
        hStack.alignment = .center
        hStack.axis = .horizontal
        
        addSubview(hStack)
        
        hStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            hStack.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            hStack.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
}
