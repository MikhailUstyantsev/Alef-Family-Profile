//
//  TableHeaderView.swift
//  AlefFamilyProfile
//
//  Created by Mikhail Ustyantsev on 20.02.2025.
//

import UIKit

protocol TableHeaderViewDelegate {
    func didTapAddChildButton()
}


final class TableHeaderView: UITableViewHeaderFooterView {
    
    var delegate: TableHeaderViewDelegate?
    
    let label = FPTitleLabel(textAlignment: .left, fontSize: 18, textColor: R.Color.black)
    let addChildButton = FPButton(color: R.Color.bluish ?? .blue, title: R.String.addChild, systemImageName: "plus")
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 16
        
        return stack
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addChildButton.rounded()
    }
    
    
    private func configure() {
        label.text = R.String.childrenMax5
        contentView.backgroundColor = .systemBackground
        
        addChildButton.layer.borderColor = R.Color.bluish?.cgColor
        addChildButton.layer.borderWidth = 2.5
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(addChildButton)
        addSubviews(stackView)
        stackView.pinToSuperviewEdges([.top, .bottom], constant: 5)
        configureAddChildButton()
    }
    
    
    func configureAddChildButton() {
        addChildButton.addTarget(self, action: #selector(addChildTapped), for: .touchUpInside)
    }
    
    @objc func addChildTapped() {
        delegate?.didTapAddChildButton()
    }
}


extension TableHeaderView: FamilyProfileViewHeaderDelegate {
    func hideAddChildButton(_ childrenCount: Int) {
        if childrenCount >= 5 {
            UIView.animate(withDuration: 0.5) {
                self.addChildButton.transform = CGAffineTransform(translationX: self.frame.width, y: 0)
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.addChildButton.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            self.addChildButton.isHidden = false
        }
    }
}
