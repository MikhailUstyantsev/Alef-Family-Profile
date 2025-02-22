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
    
    func loadChildrenFromStorage() {
        do {
            let children = try storageManager.retrieveAllChildren()
            childrenPublisher.value = children
        } catch {
            //Показать алерт в контроллере
        }
    }
    
    func deleteChildFromStorage(child: Child) throws {
        do {
            try storageManager.deleteChild(child)
            loadChildrenFromStorage()
        } catch {
            throw error
        }
    }
}
