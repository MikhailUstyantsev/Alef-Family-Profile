//
//  UITableView+Ext.swift
//  AlefFamilyProfile
//
//  Created by Mikhail Ustyantsev on 19.02.2025.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }

}
