//
//  AddChildViewController.swift
//  AlefFamilyProfile
//
//  Created by Mikhail Ustyantsev on 20.02.2025.
//

import UIKit

class AddChildViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = closeButton
    }

    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
}
