//
//  TableViewCell.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 30.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit


class TableViewCell: UITableViewCell {

    var topSeparator = UIView()
    var bottomSeparator = UIView()


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addTopSeparator()
        addBottomSeparator()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func update(with model: CellViewModel, isFirst: Bool, isLast: Bool, isDestructive: Bool) {
        imageView?.image = model.image
        textLabel?.text = model.title
        self.accessoryType = accessoryType

        topSeparator.isHidden = !isFirst
        bottomSeparator.isHidden = !isLast

        textLabel?.textColor = isDestructive ? .red : .black

        accessoryType = isDestructive ? .none : .disclosureIndicator
    }

    private func addTopSeparator() {
        topSeparator.backgroundColor = #colorLiteral(red: 0.9214878678, green: 0.9216204286, blue: 0.9253799319, alpha: 1)
        topSeparator.translatesAutoresizingMaskIntoConstraints = false

        addSubview(topSeparator)

        NSLayoutConstraint.activate([
            topSeparator.topAnchor.constraint(equalTo: topAnchor),
            topSeparator.leadingAnchor.constraint(equalTo: leadingAnchor),
            topSeparator.trailingAnchor.constraint(equalTo: trailingAnchor),
            topSeparator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    private func addBottomSeparator() {
        bottomSeparator.backgroundColor = #colorLiteral(red: 0.9410941005, green: 0.9412292838, blue: 0.9410645366, alpha: 1)
        bottomSeparator.translatesAutoresizingMaskIntoConstraints = false

        addSubview(bottomSeparator)

        NSLayoutConstraint.activate([
            bottomSeparator.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomSeparator.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomSeparator.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomSeparator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}

