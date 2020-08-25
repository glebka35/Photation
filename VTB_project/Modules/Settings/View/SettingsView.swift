//
//  SettingsViewController.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 03.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class SettingsView: UIViewController, SettingsViewInput {

//    MARK: - Properties

    var presenter: SettingsViewOutput?

    private var navigationBar: MainNavigationBar!
    private var tableViewSupervisor: TableViewSupervisor?

//    MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white

        addAndConfigureNavigationBar()
        addAndConfigureTableView()
        presenter?.viewDidLoad()
    }

//    MARK: -  UI configuration

    private func addAndConfigureTableView() {
        let tableViewSupervisor = TableViewSupervisor()
        tableViewSupervisor.delegate = self
        let table = tableViewSupervisor.getConfiguredTableView()
        view.addSubview(table)

        NSLayoutConstraint.activate([
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 15),
            table.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)
        ])

        self.tableViewSupervisor = tableViewSupervisor
    }

    private func addAndConfigureNavigationBar() {
        navigationBar = MainNavigationBar(title: LocalizedString().settings, rightTitle: nil, rightButton: nil, isSearchBarNeeded: false)

        view.addSubview(navigationBar)

        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 10),
            navigationBar.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            navigationBar.bottomAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 100)
        ])
    }

//    MARK: - UI update

    func updateTable(with data: [[CellViewModel]]) {
        tableViewSupervisor?.update(with: data)
    }

    func languageChanged() {
        let newTitle = LocalizedString().settings
        title = newTitle

        navigationBar.updateMainTitle(with: newTitle)
    }
}

//MARK: - DetailTableSupervisorDelegate

extension SettingsView: DetailTableSupervisorDelegate {
    func languageChosen(at indexPath: IndexPath) {
        presenter?.settingChoosed(at: indexPath)
    }

}
