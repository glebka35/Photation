//
//  DefaultNavigationBar.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 27.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class DefaultNavigationBar: UIView {

//    MARK: - Properties

    weak var delegate: NavigationBarDelegate?

    public var titleString: String? {
        didSet { title?.text = titleString }
    }

    public var backButtonTitle: String? {
        didSet { backButton?.setTitle(backButtonTitle, for: .normal) }
    }

    public var backButtonImage: UIImage? {
        didSet { backButton?.setImage(backButtonImage, for: .normal) }
    }

    private var title: UILabel?
    private var backButton: UIButton?

//    MARK: - Life cycle

    init(title: String?, backButtonTitle: String?, backButtonImage: UIImage?) {
        super.init(frame: .zero)

        backgroundColor = #colorLiteral(red: 0.9724641442, green: 0.9726034999, blue: 0.9724336267, alpha: 1)
        addAndConfigureTitle(with: title)
        addAndConfigureBackButton(with: backButtonTitle, and: backButtonImage )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    MARK: - UI configuration

    private func addAndConfigureTitle(with text: String?) {
        let title = UILabel()
        addSubview(title)

        title.numberOfLines = 1
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        title.text = text
        title.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])

        self.title = title
    }

    private func addAndConfigureBackButton(with title: String?, and image: UIImage?) {
        let backButton = UIButton()
        addSubview(backButton)
        backButton.setTitle(title, for: .normal)
        backButton.setTitleColor(#colorLiteral(red: 0.003280593548, green: 0.4784809947, blue: 0.9998757243, alpha: 1), for: .normal)
        backButton.setImage(image, for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false

        backButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5)
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)

        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])

        backButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        self.backButton = backButton
    }

//    MARK: - User interaction

    @objc func buttonAction(sender: UIButton!) {
        delegate?.action(sender: sender)
    }
}
