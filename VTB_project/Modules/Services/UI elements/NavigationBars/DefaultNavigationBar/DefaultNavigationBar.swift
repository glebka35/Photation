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

    private let titleLabel = UILabel()
    private let backButton = UIButton()

    lazy var horizontalConstraint: NSLayoutConstraint = {
        let constraint = backButton.trailingAnchor.constraint(lessThanOrEqualTo: titleLabel.leadingAnchor, constant: -5)
        constraint.priority = .init(rawValue: 700)
        return constraint
    }()

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

        addSubview(titleLabel)

        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabel.text = text
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.minimumScaleFactor = 0.1
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        let constraint = titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        constraint.priority = .init(rawValue: 300)

        NSLayoutConstraint.activate([
            constraint,
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: -layoutMargins.right)
        ])
    }

    private func addAndConfigureBackButton(with title: String?, and image: UIImage?) {

        addSubview(backButton)
        backButton.setTitle(title, for: .normal)
        backButton.setTitleColor(#colorLiteral(red: 0.003280593548, green: 0.4784809947, blue: 0.9998757243, alpha: 1), for: .normal)
        backButton.setImage(image, for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false

        backButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: -5)
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)

        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: layoutMargins.left),
            backButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])

        backButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }

    //    MARK: - UI update

    func updateTitle(with text: String) {
        titleLabel.text = text
    }

    func update(with model: DefaultNavigationBarModel) {
        titleLabel.text = model.title
        backButton.setTitle(model.backButtonTitle, for: .normal)
    }

    //    MARK: - User interaction

    @objc func buttonAction(sender: UIButton!) {
        delegate?.action(sender: sender)
    }
}
