//
//  AddChildViewController.swift
//  AlefFamilyProfile
//
//  Created by Mikhail Ustyantsev on 20.02.2025.
//

import UIKit

final class AddChildViewController: UIViewController {
    
    enum TextFieldData: Int {
        case nameTextField = 0
        case ageTextField
    }
    
    private let inputNameView = BaseInputView()
    private let inputAgeView = BaseInputView()
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 10
        
        return stack
    }()
    let saveChildButton = FPButton(color: R.Color.lightRed ?? .red, title: R.String.save, systemImageName: "")
    var dummyChild = DummyChild(name: "", age: 0)
    var callBack: ((DummyChild) -> Void) = { _ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        dismissKeyboardTapGesture()
    }
    
    
    private func dismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        saveChildButton.rounded()
    }
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = closeButton
        
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
    
    
    private func setupViews() {
        inputNameView.setupSubviews(
            titletext: R.String.name,
            textFieldPlaceholder: R.String.enterName
        )
        
        inputAgeView.setupSubviews(
            titletext: R.String.age,
            textFieldPlaceholder: R.String.enterAge
        )
        
        saveChildButton.layer.borderColor = R.Color.lightRed?.cgColor
        saveChildButton.layer.borderWidth = 2.5
        saveChildButton.addTarget(self, action: #selector(saveChildTapped), for: .touchUpInside)
        
        inputNameView.textField.tag = 0
        inputNameView.textField.delegate = self
        
        inputAgeView.textField.tag = 1
        inputAgeView.textField.keyboardType = .numberPad
        inputAgeView.textField.delegate = self
    }
    
    
    @objc private func saveChildTapped() {
        callBack(dummyChild)
        dismissVC()
    }
    
    
    private func setupHierarchy() {
        stackView.addArrangedSubview(inputNameView)
        stackView.addArrangedSubview(inputAgeView)
        view.addSubviews(stackView, saveChildButton)
    }
    
    
    private func setupLayout() {
        let margins: CGFloat = 20
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: margins),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -margins),
            stackView.heightAnchor.constraint(equalToConstant: 200),
            
            saveChildButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            saveChildButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveChildButton.widthAnchor.constraint(equalToConstant: 200),
            saveChildButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    
    @objc private func textfieldValueChanged(_ textField: UITextField){
        
        guard let text = textField.text else { return }
        switch textField.tag {
            
        case TextFieldData.nameTextField.rawValue:
            dummyChild.name = text
            
        case TextFieldData.ageTextField.rawValue:
            dummyChild.age = Int16(text) ?? 0
            
        default:
            break
        }
    }
    
    
    deinit {
        print("deinit AddChildViewController")
    }
}


extension AddChildViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(textfieldValueChanged), for: .editingChanged)
    }
    
}
