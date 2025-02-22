//
//  BaseInputView.swift
//  AlefFamilyProfile
//
//  Created by Mikhail Ustyantsev on 20.02.2025.
//

import UIKit

class BaseInputView: UIView {

    private let titleLabel  = UILabel()
    let textField = FPTextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupViews() {
        titleLabel.font = R.Font.montserratRegular(with: 14)
        titleLabel.textColor = .secondaryLabel
        titleLabel.setContentHuggingPriority(.defaultHigh + 1, for: .vertical)
        
        textField.clearButtonMode = .whileEditing
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .secondarySystemBackground
        
    }
    
    
    private func setupHierarchy() {
        addSubviews(titleLabel, textField)
    }
    
    
    private func setupLayout() {
        let topOffset: CGFloat = 8
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: topOffset),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topOffset),
        ])
        textField.pinToSuperviewEdges([.left, .bottom, .right])
    }
    
    //MARK: - Public functions
    func setupSubviews(
        titletext: String,
        textFieldPlaceholder: String
    ) {
        titleLabel.text = titletext
        textField.placeholder = textFieldPlaceholder
    }
    
    
}
