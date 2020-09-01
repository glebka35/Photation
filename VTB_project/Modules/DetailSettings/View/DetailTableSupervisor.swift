//
//  DetailTableSupervisor.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 30.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

//MARK: - DetailTableSupervisorDelegate

protocol DetailTableSupervisorDelegate: AnyObject {
    func languageChosen(at indexPath: IndexPath)
}

//MARK: - DetailTableSupervisor

class DetailTableSupervisor: NSObject {

//    MARK: - Properties

    private var viewModel: [LanguageCellViewModel] = []
    private var tableView: UITableView

    weak var delegate: DetailTableSupervisorDelegate?

    private var selectedRow: IndexPath?

//    MARK: - Life cycle

    override init() {
        tableView = UITableView()
    }

//    MARK: - UI configuration

    func getConfiguredTableView()->UITableView {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }

//    MARK: - UI update

    func update(with data: [LanguageCellViewModel]) {
        self.viewModel = data
        tableView.reloadData()
    }
}

//MARK: - UITableViewDelegate

extension DetailTableSupervisor: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.languageChosen(at: indexPath)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        selectedRow = indexPath
    }

}

//MARK: - UITableViewDataSource

extension DetailTableSupervisor: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? TableViewCell {
            let isFirst = indexPath.row == 0
            let isLast = indexPath.row == viewModel.count - 1

            cell.update(with: viewModel[indexPath.row], isFirst: isFirst, isLast: isLast)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cellDetail") as? TableViewCell {
            return cell
        } else {
            return TableViewCell(style: .subtitle, reuseIdentifier: "cellDetail")
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
}
