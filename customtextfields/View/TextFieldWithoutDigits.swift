//
//  CustomTextField.swift
//  customtextfields
//
//  Created by Anastasia Tochilova  on 01.06.2024.
//

import UIKit

final class TextFieldWithoutDigits: UITextField {
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods
    
    private func setup() {
        self.delegate = self
    }
}

extension TextFieldWithoutDigits: UITextFieldDelegate {
    // MARK: - UITextFieldDelegate Methods
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Exclude digits
        let characterSet = CharacterSet.decimalDigits
        let filteredString = string.components(separatedBy: characterSet).joined()
        return string == filteredString
    }
}
