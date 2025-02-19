//
//  TableHeaderView.swift
//  AlefFamilyProfile
//
//  Created by Mikhail Ustyantsev on 20.02.2025.
//

import UIKit

class TableHeaderView: UITableViewHeaderFooterView {

        override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
            configure()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func configure() {
            contentView.backgroundColor = .cyan
            
            NSLayoutConstraint.activate([
              
            ])
        }

}
