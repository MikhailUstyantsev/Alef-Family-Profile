//
//  ChildInfoTableViewCell.swift
//  AlefFamilyProfile
//
//  Created by Mikhail Ustyantsev on 20.02.2025.
//

import UIKit

protocol ChildInfoTableViewCellDelegate: AnyObject {
    func deleteObjectFromStorage(_ child: Child?)
}

final class ChildInfoTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    var delegate: ChildInfoTableViewCellDelegate?
    var child: Child?
    private let nameView = TitleValueView()
    private let ageView = TitleValueView()
    private let deleteButton = FPButton(color: .bluish, title: R.String.delete, systemImageName: "")
    
    private let spacer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let upperStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.spacing = 0
        
        return stack
    }()
    
    private let lowerStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    private let verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureAppearance()
        setupHierarchy()
        setupLayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureAppearance() {
        contentView.backgroundColor = .clear
    }
    
    
    private func setupHierarchy() {
        upperStackView.addArrangedSubview(nameView)
        upperStackView.addArrangedSubview(deleteButton)
        
        lowerStackView.addArrangedSubview(ageView)
        lowerStackView.addArrangedSubview(spacer)
        
        verticalStackView.addArrangedSubview(upperStackView)
        verticalStackView.addArrangedSubview(lowerStackView)
        
        contentView.addSubviews(verticalStackView)
    }
    
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        verticalStackView.pinToSuperviewEdges([.top, .bottom], constant: 20)
    }
    
    
    @objc private func deleteChildFromStorage() {
        delegate?.deleteObjectFromStorage(child)
    }
    
    
    //MARK: Public functions
    func set(with child: Child) {
        nameView.set(R.String.name, with: child.name ?? "not set")
        ageView.set(R.String.age, with: String(describing: child.age))
        deleteButton.addTarget(self, action: #selector(deleteChildFromStorage), for: .touchUpInside)
    }
}
