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
    var childrenPublisher = PassthroughSubject<[Child], Never>()
    
    func loadChildrenFromStorage() {
        do {
            let children = try storageManager.retrieveAllChildren()
            childrenPublisher.send(children)
        } catch {
            //Показать алерт в контроллере
        }
    }
    
    func deleteChildFromStorage(child: Child) throws {
        do {
            try storageManager.deleteChild(child)
            loadChildrenFromStorage()
        } catch let error as StorageError {
            throw error
        }
    }
}
