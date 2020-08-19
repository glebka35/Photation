//
//  RememberFooterReusableView.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 18.08.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

protocol FooterActionDelegate: AnyObject {
    func performAction()
}

class RememberFooterView: UIView {

//    MARK: - Properties

    private let progressLabel = UILabel()
    private let vStack =  UIStackView()
    private let nextButton = UIButton()

    weak var delegate: FooterActionDelegate?

//    MARK: - Life cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        addAndConfigureProgressLabel()
        addAndConfigureNextButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    MARK: - UI configuration

    private func addAndConfigureProgressLabel() {
        progressLabel.numberOfLines = 1
        progressLabel.textColor = .black
        progressLabel.textAlignment = .center
        progressLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        progressLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(progressLabel)

        NSLayoutConstraint.activate([
            progressLabel.topAnchor.constraint(equalTo: topAnchor),
            progressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            progressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }

    private func addAndConfigureNextButton() {
//        nextButton.setTitle("Дальше", for: .normal)
        nextButton.setImage(UIImage(named: "next"), for: .normal)
        nextButton.addTarget(self, action: #selector(performAction), for: .touchUpInside)
        nextButton.setTitleColor(.blue, for: .normal)
        nextButton.layer.cornerRadius = 10
        nextButton.clipsToBounds = true
        nextButton.layer.borderWidth = 2
        nextButton.layer.borderColor = UIColor.blue.cgColor
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        nextButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        nextButton.translatesAutoresizingMaskIntoConstraints = false

        addSubview(nextButton)

        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 20),
            nextButton.heightAnchor.constraint(equalToConstant: 70),
            nextButton.widthAnchor.constraint(equalToConstant: 70),
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

//    MARK: - UI update

    func update(with model: FooterModel) {
        progressLabel.text = String(model.currentIndex) + " / " + String(model.amount)
    }

    func hideNextButton(bool: Bool) {
        nextButton.isHidden = bool
    }

//    MARK: - User interaction

    @objc private func performAction() {
        delegate?.performAction()
    }
}
