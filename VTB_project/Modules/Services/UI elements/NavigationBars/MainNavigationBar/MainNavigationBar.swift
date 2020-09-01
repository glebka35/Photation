//
//  NavigationBar.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 07.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class MainNavigationBar: UIView {

    //    MARK: - Properties
    
    weak var delegate: NavigationBarDelegate?
    weak var searchBarDelegate: UISearchBarDelegate? {
        didSet {
            searchBar?.delegate = searchBarDelegate
        }
    }
    
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

    //    MARK: - Life cycle

    init(title: String, rightTitle: String? = nil, rightButton: UIButton? = nil, isSearchBarNeeded: Bool) {
        super.init(frame: .zero)

        addAndConfigureTitle(with: title)

        if let rightTitle = rightTitle {
            addAndConfigureRightTitle(with: rightTitle)
        }

        if let rightButton = rightButton {
            addAndConfigureRightButton(with: rightButton)
        }

        embedInStackView()

        if isSearchBarNeeded {
            addAndConfigureSearchBar()
        }

        translatesAutoresizingMaskIntoConstraints = false
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //    MARK: - UI configuration
    
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

        rightTitle.minimumScaleFactor = 0.1
        rightTitle.adjustsFontSizeToFitWidth = true
        rightTitle.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        self.rightTitle = rightTitle
    }
    
    private func addAndConfigureRightButton(with button: UIButton) {
        button.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
        self.rightButton = button
    }

    private func addAndConfigureSearchBar() {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchBar)

        if #available(iOS 11, *) {
            searchBar.backgroundImage = UIImage()
        } else {
            searchBar.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            searchBar.layer.cornerRadius = 5
            searchBar.clipsToBounds = true
        }

        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -layoutMargins.left),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: layoutMargins.right),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        searchBar.delegate = searchBarDelegate
        self.searchBar = searchBar
    }

    private func embedInStackView() {
        let viewsToBeEmbedInStack: [UIView] = [title, rightTitle, rightButton].compactMap({ $0 })

        let hStack = UIStackView(arrangedSubviews: viewsToBeEmbedInStack)

        hStack.distribution = .equalSpacing
        hStack.alignment = .center
        hStack.axis = .horizontal
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.spacing = 10

        addSubview(hStack)

        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            hStack.topAnchor.constraint(equalTo: topAnchor)
        ])
    }

    //    MARK: - UI update

    func update(with model: MainNavigationBarModel) {
        title?.text = model.title
        rightTitle?.text = model.additionalTitle
        rightButton?.setTitle(model.buttonTitle, for: .normal)
    }

    func updateRightTitle(with text: String) {
        rightTitle?.text = text
    }

    func updateMainTitle(with text: String) {
        title?.text = text
    }

    func showRightButton(bool: Bool) {
        rightButton?.isHidden = !bool
    }

    func clearSearchBar() {
        searchBar?.text = ""
    }


    //    MARK: - User interaction
    
    @objc func rightButtonAction(sender: UIButton!) {
        sender.pulsate()
        delegate?.action(sender: sender)
    }
}
