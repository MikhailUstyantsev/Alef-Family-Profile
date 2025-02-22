//
//  ErrorPresenter.swift
//  AlefFamilyProfile
//
//  Created by Mikhail Ustyantsev on 19.02.2025.
//

import UIKit

enum ErrorPresenter {
  static func showError(message: String, on viewController: UIViewController?, dismissAction: ((UIAlertAction) -> Void)? = nil) {
    weak var weakViewController = viewController
    DispatchQueue.main.async {
      let alertController = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: dismissAction))
      weakViewController?.present(alertController, animated: true)
    }
  }
}
