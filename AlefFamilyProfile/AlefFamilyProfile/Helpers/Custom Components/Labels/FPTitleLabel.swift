//
//  FPTitleLabel.swift
//  AlefFamilyProfile
//
//  Created by Mikhail Ustyantsev on 20.02.2025.
//

import UIKit

class FPTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat, textColor: UIColor?) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = R.Font.montserratSemiBold(with: fontSize)
        self.textColor = textColor
    }
    
    
    private func configure() {
        adjustsFontSizeToFitWidth     = true
        minimumScaleFactor            = 0.9
        lineBreakMode                 = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }

}
