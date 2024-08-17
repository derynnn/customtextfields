//
//  PasswordTextField.swift
//  customtextfields
//
//  Created by Anastasia Tochilova  on 01.06.2024.
//

import UIKit

final class PasswordTextField: UITextField {
    
    // MARK: - Properties
    
    private let minLength: Int
    private let requiresDigit: Bool
    private let requiresLowercase: Bool
    private let requiresUppercase: Bool
    
    private let strengthLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    
    private let requirementsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()

    // MARK: - Initializers
    
    init(minLength: Int, requiresDigit: Bool, requiresLowercase: Bool, requiresUppercase: Bool) {
        self.minLength = minLength
        self.requiresDigit = requiresDigit
        self.requiresLowercase = requiresLowercase
        self.requiresUppercase = requiresUppercase
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods
    
    private func setup() {
        self.delegate = self
        setupStrengthLabel()
        setupRequirementsLabel()
    }

    private func setupStrengthLabel() {
        addSubview(strengthLabel)
        strengthLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            strengthLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            strengthLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        updateStrengthLabel()
    }

    private func setupRequirementsLabel() {
        addSubview(requirementsLabel)
        requirementsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            requirementsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            requirementsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        updateRequirementsLabel()
    }

    private func updateStrengthLabel() {
        let strength = evaluatePasswordStrength()
        strengthLabel.text = strength
        switch strength {
        case "Weak":
            strengthLabel.textColor = .red
        case "Medium":
            strengthLabel.textColor = .orange
        case "Strong":
            strengthLabel.textColor = .green
        default:
            strengthLabel.textColor = .black
        }
    }

    private func updateRequirementsLabel() {
        var requirementsText = ""
        if requiresDigit {
            requirementsText += "• Must contain a digit\n"
        }
        if requiresLowercase {
            requirementsText += "• Must contain a lowercase letter\n"
        }
        if requiresUppercase {
            requirementsText += "• Must contain an uppercase letter\n"
        }
        requirementsText += "• Minimum length: \(minLength)"
        requirementsLabel.text = requirementsText
    }

    private func evaluatePasswordStrength() -> String {
        guard let password = self.text else { return "Unknown" }
        var strength = "Weak"
        let lengthCondition = password.count >= minLength
        let digitCondition = requiresDigit && password.rangeOfCharacter(from: .decimalDigits) != nil
        let lowercaseCondition = requiresLowercase && password.rangeOfCharacter(from: .lowercaseLetters) != nil
        let uppercaseCondition = requiresUppercase && password.rangeOfCharacter(from: .uppercaseLetters) != nil
        
        if lengthCondition && digitCondition && lowercaseCondition && uppercaseCondition {
            strength = "Strong"
        } else if lengthCondition && (digitCondition || lowercaseCondition || uppercaseCondition) {
            strength = "Medium"
        }
        
        return strength
    }
}

extension PasswordTextField: UITextFieldDelegate {
    // MARK: - UITextFieldDelegate Methods
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        updateStrengthLabel()
        return true
    }
}
