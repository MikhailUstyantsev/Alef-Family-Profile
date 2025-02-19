//
//  ParentInfoView.swift
//  AlefFamilyProfile
//
//  Created by Mikhail Ustyantsev on 19.02.2025.
//

import UIKit

final class ParentInfoView: UIView {

    let parent: Parent
    private let nameView = TitleValueView()
    private let ageView = TitleValueView()
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    init(parent: Parent) {
        self.parent = parent
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
       
        nameView.set(R.String.name, with: parent.name ?? "not set")
        ageView.set(R.String.age, with: String(describing: parent.age))
       
        stackView.addArrangedSubview(nameView)
        stackView.addArrangedSubview(ageView)
        
        addSubviews(stackView)
        
        stackView.pinToSuperviewEdges()
    }

}
