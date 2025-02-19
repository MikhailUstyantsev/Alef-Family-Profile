//
//  FamilyProfileViewController.swift
//  AlefFamilyProfile
//
//  Created by Mikhail Ustyantsev on 19.02.2025.
//

import UIKit

class FamilyProfileViewController: UIViewController {

    private let storageManager = StorageManager()
    let titleLabel = UILabel()
    private let marginOffset: CGFloat = 20
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }


    private func setupTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = R.String.title
        titleLabel.textColor = R.Color.black
        titleLabel.font = R.Font.montserratSemiBold(with: 18)
        view.addSubviews(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: marginOffset),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
    }
    
    private func setupParentView() {
        let parent = Parent(context: storageManager.managedObjectContext)
        parent.name = "Петр"
        parent.age = 99
        let parentView = ParentInfoView(parent: parent)
        view.addSubviews(parentView)
        NSLayoutConstraint.activate([
            parentView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            parentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: marginOffset),
            parentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -marginOffset),
            parentView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        setupTitle()
        setupParentView()
    }
    
    
    
    
    
    
    
}

