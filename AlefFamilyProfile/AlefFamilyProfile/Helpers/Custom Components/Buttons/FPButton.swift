//
//  FPButton.swift
//  AlefFamilyProfile
//
//  Created by Mikhail Ustyantsev on 20.02.2025.
//

import UIKit

class FPButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(color: UIColor, title: String, systemImageName: String) {
        self.init(frame: .zero)
        set(color: color, title: title, systemImageName: systemImageName)
    }
    
    
    private func configure() {
        
        configuration = .plain()
        configuration?.cornerStyle = .capsule
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func set(color: UIColor, title: String, systemImageName: String) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = color
        configuration?.title = title
    
        configuration?.image = UIImage(systemName: systemImageName)
        configuration?.imagePadding = 6
        configuration?.imagePlacement = .leading
    }

}
