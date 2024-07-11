//
//  CounterTextField.swift
//  customtextfields
//
//  Created by Anastasia Tochilova  on 01.06.2024.
//

import UIKit

class CounterTextField: UITextField, UITextFieldDelegate {
    private let counterLabel = UILabel()
    private let maxLength: Int
    private let borderColor = UIColor.red.cgColor

    init(maxLength: Int) {
        self.maxLength = maxLength
        super.init(frame: .zero)
        self.delegate = self
        setupCounterLabel()
    }

    required init?(coder: NSCoder) {
        self.maxLength = 10
        super.init(coder: coder)
        self.delegate = self
        setupCounterLabel()
    }

    private func setupCounterLabel() {
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(counterLabel)
        NSLayoutConstraint.activate([
            counterLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            counterLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -4)
        ])
        updateCounterLabel()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        if newLength > maxLength {
            textField.layer.borderColor = borderColor
            textField.layer.borderWidth = 1.0
        } else {
            textField.layer.borderWidth = 0
        }
        updateCounterLabel(newLength: newLength)
        return true
    }

    private func updateCounterLabel(newLength: Int? = nil) {
        guard let text = self.text else { return }
        let length = newLength ?? text.count
        counterLabel.text = "\(maxLength - length)"
        if length > maxLength {
            counterLabel.textColor = .red
        } else {
            counterLabel.textColor = .black
        }
    }
}
