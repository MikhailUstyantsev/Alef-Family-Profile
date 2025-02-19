//
// R.swift
// AlefFamilyProfile
//
//  Created by Mikhail Ustyantsev on 19.02.2025.
//

import UIKit

enum R {
    
    enum Constant {
        static let titleValueViewHeight: CGFloat = 40
    }
    
    enum Color {
        static let black = UIColor(named: "black")
        static let lightGrey = UIColor(named: "light-grey")
        static let bluish = UIColor(named: "bluish")
        static let lightRed = UIColor(named: "light-red")
        static let grey = UIColor(named: "grey")
    }
    
    
    enum String {
        static let title = "Персональные данные"
        static let name = "Имя"
        static let age = "Возраст"
        static let addChild = "Добавить ребенка"
        static let clear = "Очистить"
        static let delete = "Удалить"
    }
    
    
    enum Image {
        static let plus = UIImage(systemName: "plus")
    }
    
    
    enum Font {
        
        static func helveticaRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Helvetica", size: size) ?? UIFont()
        }
        
        static func montserratRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Montserrat-Regular", size: size) ?? UIFont()
        }
        
        static func montserratMedium(with size: CGFloat) -> UIFont {
            UIFont(name: "Montserrat-Medium", size: size) ?? UIFont()
        }
        
        static func montserratSemiBold(with size: CGFloat) -> UIFont {
            UIFont(name: "Montserrat-SemiBold", size: size) ?? UIFont()
        }
        
        static func montserratLight(with size: CGFloat) -> UIFont {
            UIFont(name: "Montserrat-Light", size: size) ?? UIFont()
        }
    }
    
    
}
