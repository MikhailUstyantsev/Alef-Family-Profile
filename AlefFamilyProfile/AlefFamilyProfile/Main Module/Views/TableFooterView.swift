//
//  TableFooterView.swift
//  AlefFamilyProfile
//
//  Created by Mikhail Ustyantsev on 22.02.2025.
//

import UIKit

final class TableFooterView: UITableViewHeaderFooterView {
    
    
    let deleteAllChildrenButton = FPButton(color: R.Color.lightRed ?? .red, title: R.String.clear, systemImageName: "")
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        deleteAllChildrenButton.rounded()
    }
    
    
    private func configure() {
            deleteAllChildrenButton.layer.borderColor = R.Color.lightRed?.cgColor
            deleteAllChildrenButton.layer.borderWidth = 2.5
            addSubviews(deleteAllChildrenButton)
            
            NSLayoutConstraint.activate([
                deleteAllChildrenButton.topAnchor.constraint(equalTo: topAnchor),
                deleteAllChildrenButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                deleteAllChildrenButton.widthAnchor.constraint(equalToConstant: 200),
                deleteAllChildrenButton.heightAnchor.constraint(equalToConstant: 50),
            ])
        
        deleteAllChildrenButton.addTarget(self, action: #selector(deleteAllChildrenTapped), for: .touchUpInside)
    }
    
    @objc func deleteAllChildrenTapped() {
        print("--> deleting all children...")
    }
}



extension TableFooterView: FamilyProfileViewFooterDelegate {
    
    func hideDeleteAllChildrenButton(_ childrenCount: Int) {
        if childrenCount > 0 {
            UIView.animate(withDuration: 0.3) {
                self.deleteAllChildrenButton.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.deleteAllChildrenButton.isHidden = true
            }
        }
    }
}
