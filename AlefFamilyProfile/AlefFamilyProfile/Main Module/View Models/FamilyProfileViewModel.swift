//
//  FamilyProfileViewModel.swift
//  AlefFamilyProfile
//
//  Created by Mikhail Ustyantsev on 20.02.2025.
//

import Foundation
import Combine

final class FamilyProfileViewModel: NSObject {
    
    let storageManager = StorageManager.shared
    var childrenPublisher = CurrentValueSubject<[Child], Never>([])
    var storageCapacity = 0
    
    func loadChildrenFromStorage() {
        do {
            let children = try storageManager.retrieveAllChildren()
            storageCapacity = children.count
            childrenPublisher.value = children
        } catch {
            //Показать алерт в контроллере
        }
    }
    
    
}
