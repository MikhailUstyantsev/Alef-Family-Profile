//
//  StorageError.swift
//  AlefFamilyProfile
//
//  Created by Mikhail Ustyantsev on 19.02.2025.
//

import Foundation

enum StorageError: String, Error {
    case savingError = "Не удалось сохранить данные в постоянном хранилище."
    case deletingError = "Не удалось удалить объект из постоянного хранилища."
    case retrieveError = "Не удалось загрузить ваши данные из постоянного хранилища."
}
