//
//  PasswordTextField.swift
//  customtextfields
//
//  Created by Anastasia Tochilova  on 01.06.2024.
//

import UIKit

class PasswordTextField: UITextField, UITextFieldDelegate {
    private let rulesLabel = UILabel()
    private let minLength = 8

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        setupRulesLabel()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.delegate = self
        setupRulesLabel()
    }

    private func setupRulesLabel() {
        rulesLabel.translatesAutoresizingMaskIntoConstraints = false
        rulesLabel.numberOfLines = 0
        self.addSubview(rulesLabel)
        NSLayoutConstraint.activate([
            rulesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            rulesLabel.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 8)
        ])
        updateRulesLabel()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        updateRulesLabel(text: newString)
        return true
    }

    private func updateRulesLabel(text: String? = nil) {
        guard let text = text else { return }
        var rules = ""
        rules += text.count >= minLength ? "✓ " : "✗ "
        rules += "Min \(minLength) characters\n"
        rules += text.rangeOfCharacter(from: CharacterSet.lowercaseLetters) != nil ? "✓ " : "✗ "
        rules += "At least one lowercase letter\n"
        rules += text.rangeOfCharacter(from: CharacterSet.uppercaseLetters) != nil ? "✓ " : "✗ "
        rules += "At least one uppercase letter\n"
        rules += text.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil ? "✓ " : "✗ "
        rules += "At least one digit\n"
        rulesLabel.text = rules
    }
}

