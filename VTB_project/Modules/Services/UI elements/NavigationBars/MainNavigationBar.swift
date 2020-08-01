//
//  NavigationBar.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 07.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class MainNavigationBar: UIView {
    
    weak var delegate: NavigationBarDelegate?
    
    public var titleString: String? {
        didSet { title?.text = titleString }
    }
    
    public var rightTitleString: String? {
        didSet { rightTitle?.text = rightTitleString }
    }
    
    public var rightButtonImage: UIImage? {
        didSet { rightButton?.setImage(rightButtonImage, for: .normal) }
    }
    
    private var title: UILabel?
    private var rightTitle: UILabel?
    private var rightButton: UIButton?
    private var searchBar: UISearchBar?

    init(title: String, rightTitle: String?, rightButtonImage: UIImage?, isSearchBarNeeded: Bool) {
        super.init(frame: .zero)

        addAndConfigureTitle(with: title)

        if let rightTitle = rightTitle {
            addAndConfigureRightTitle(with: rightTitle)
        }

        if let rightButtonImage = rightButtonImage {
            addAndConfigureRightButton(with: rightButtonImage)
        }

        embedInStackView()

        if isSearchBarNeeded {
            addAndConfigureSearchBar()
        }
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addAndConfigureTitle(with text: String) {
        let title = UILabel()
        addSubview(title)
        
        title.numberOfLines = 1
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        title.text = text

        self.title = title
    }
    
    private func addAndConfigureRightTitle(with name: String) {
        let rightTitle = UILabel()
        addSubview(rightTitle)
        
        rightTitle.numberOfLines = 1
        rightTitle.textAlignment = .center
        rightTitle.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        rightTitle.textColor = UIColor(displayP3Red: 104/255, green: 105/255, blue: 105/255, alpha: 1)
        rightTitle.text = name

        self.rightTitle = rightTitle
    }
    
    private func addAndConfigureRightButton(with image: UIImage) {
        let rightButton = UIButton()
        rightButton.setImage(image, for: .normal)
        addSubview(rightButton)
        
        rightButton.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)

        self.rightButton = rightButton
    }
    
    @objc func rightButtonAction(sender: UIButton!) {
        delegate?.action(sender: sender)
    }
    
    private func addAndConfigureSearchBar() {
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        self.searchBar = searchBar
    }
    
    private func embedInStackView() {
        let viewsToBeEmbedInStack: [UIView] = [title, rightTitle, rightButton].compactMap({ $0 })

        let hStack = UIStackView(arrangedSubviews: viewsToBeEmbedInStack)
        
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
