//
//  ChildInfoTableViewCell.swift
//  AlefFamilyProfile
//
//  Created by Mikhail Ustyantsev on 20.02.2025.
//

import UIKit

protocol ChildInfoTableViewCellDelegate: AnyObject {
    func deleteObjectFromStorage(at indexPath: IndexPath?)
}

final class ChildInfoTableViewCell: UITableViewCell {

    //MARK: - Properties
    
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureAppearance()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureAppearance() {
        contentView.backgroundColor = .yellow
    }
    
}
