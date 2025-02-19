//
//  TitleValueView.swift
//  AlefFamilyProfile
//
//  Created by Mikhail Ustyantsev on 19.02.2025.
//

import UIKit

final class TitleValueView: UIView {
    
    private let titleLabel = FPLabel(textAlignment: .left, fontSize: 14, textColor: R.Color.grey)
    private let valueLabel = FPLabel(textAlignment: .left, fontSize: 14, textColor: R.Color.black)
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 6
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
        addSubviews(stackView)
        stackView.pinToSuperviewEdges([.top, .bottom])
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
        layer.borderColor = R.Color.lightGrey?.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 5.0
    }
    
    //MARK: Public functions
    func set(_ titleText: String, with value: String) {
        titleLabel.text = titleText
        valueLabel.text = value
    }
}
