//
//  CounterTextField.swift
//  customtextfields
//
//  Created by Anastasia Tochilova  on 01.06.2024.
//

import UIKit

final class TextFieldWithCounter: UITextField {
    
    // MARK: - Properties
    
    private let maxLength: Int

    // MARK: - Private Properties
    
    private let counterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()

    // MARK: - Initializers
    
    init(maxLength: Int) {
        self.maxLength = maxLength
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods
    
    private func setup() {
        self.delegate = self
        setupCounterLabel()
    }

    private func setupCounterLabel() {
        addSubview(counterLabel)
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            counterLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            counterLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        updateCounterLabel()
    }

    private func updateCounterLabel(newLength: Int? = nil) {
        let length = newLength ?? text?.count ?? 0
        let remaining = maxLength - length
        counterLabel.text = "\(remaining)"
        if remaining < 0 {
            counterLabel.textColor = .red
            layer.borderColor = UIColor.red.cgColor
        } else {
            counterLabel.textColor = .black
            layer.borderColor = UIColor.black.cgColor
        }
    }
}

extension TextFieldWithCounter: UITextFieldDelegate {
    // MARK: - UITextFieldDelegate Methods
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        updateCounterLabel(newLength: newString.count)
        return newString.count <= maxLength
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateCounterLabel()
    }
}
