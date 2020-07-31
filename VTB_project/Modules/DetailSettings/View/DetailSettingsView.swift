//
//  DetailSettingsView.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 30.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class DetailSettingsView: UIViewController, DetailSettingsViewInput {
    var presenter: DetailSettingsViewOutput?

    private var navigationBar: DefaultNavigationBar?
    private var tableViewSupervisor: DetailTableSupervisor?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addAndConfigureNavigationBar()
        addAndConfigureTableView()
        presenter?.viewDidLoad()
    }

    func set(title: String) {
        self.title = title
        navigationBar?.titleString = title
    }

    func updateTable(with data: [LanguageCellViewModel]) {
        tableViewSupervisor?.update(with: data)
    }

    private func addAndConfigureTableView() {
        let tableViewSupervisor = DetailTableSupervisor()
        tableViewSupervisor.delegate = self
        let table = tableViewSupervisor.getConfiguredTableView()
        view.addSubview(table)

        if let navigationBar = navigationBar {
            NSLayoutConstraint.activate([
                table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                table.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
                table.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)
            ])
        }

        self.tableViewSupervisor = tableViewSupervisor
    }

    private func addAndConfigureNavigationBar() {
        let navigationBar = DefaultNavigationBar(title: title, backButtonTitle: "Назад", backButtonImage: UIImage(named: "leftAccessory"))
        view.addSubview(navigationBar)
        navigationBar.delegate = self

        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.bottomAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 40)
        ])

        self.navigationBar = navigationBar
    }

}

extension DetailSettingsView: NavigationBarDelegate {
    func action(sender: UIButton!) {
        presenter?.backButtonPressed()
    }
}

extension DetailSettingsView: DetailTableSupervisorDelegate {
    func languageChosen(at indexPath: IndexPath) {
        presenter?.languageChoosen(at: indexPath)
    }
}
