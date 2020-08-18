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

class RememberFooterReusableView: UICollectionReusableView {

//    MARK: - Properties

    private let progressLabel = UILabel()
    private let scoreLabel = UILabel()
    private let vStack: UIStackView = UIStackView()
    private let nextButton = UIButton()

    weak var delegate: FooterActionDelegate?

//    MARK: - Life cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureProgressLabel()
        configureScoreLabel()
        embedInStack()

        addAndConfigureNextButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    MARK: - UI configuration

    private func configureProgressLabel() {
        progressLabel.numberOfLines = 1
        progressLabel.textColor = .black
        progressLabel.textAlignment = .center
        progressLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureScoreLabel() {
        scoreLabel.numberOfLines = 1
        scoreLabel.textColor = .black
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func addAndConfigureNextButton() {
        nextButton.setTitle("Дальше", for: .normal)
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
            nextButton.topAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 20),
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    private func embedInStack() {
        vStack.addArrangedSubview(progressLabel)
        vStack.addArrangedSubview(scoreLabel)

        vStack.axis = .vertical
        vStack.alignment = .center
        vStack.distribution = .equalSpacing
        vStack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(vStack)

        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: topAnchor),
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }

//    MARK: - UI update

    func update(with model: FooterModel, isNextButtonHidden: Bool) {
        progressLabel.text = String(model.currentIndex) + " из " + String(model.amount)
        scoreLabel.text = "Правильно: " + String(model.guessed)
        nextButton.isHidden = isNextButtonHidden
    }

//    MARK: - User interaction

    @objc private func performAction() {
        delegate?.performAction()
    }

}
