//
//  MaskedTextField.swift
//  customtextfields
//
//  Created by Anastasia Tochilova  on 01.06.2024.
//

import UIKit

final class MaskedTextField: UITextField {
    
    private let inputMask: String

    init(inputMask: String) {
        self.inputMask = inputMask
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.delegate = self
    }

    private func applyMask(to text: String) -> String {
        var maskedText = ""
        var index = 0
        let filteredText = text.filter { $0.isLetter || $0.isNumber }
        
        for char in inputMask {
            guard index < filteredText.count else { break }
            let filteredIndex = filteredText.index(filteredText.startIndex, offsetBy: index)
            let currentChar = filteredText[filteredIndex]
            
            switch char {
            case "w":
                if currentChar.isLetter {
                    maskedText.append(currentChar)
                    index += 1
                } else {
                    return maskedText
                }
                
            case "d":
                if currentChar.isNumber {
                    maskedText.append(currentChar)
                    index += 1
                } else {
                    return maskedText
                }
                
            default:
                maskedText.append(char)
            }
        }
        
        return maskedText
    }
}

extension MaskedTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text as NSString? {
            let newText = text.replacingCharacters(in: range, with: string)
            textField.text = applyMask(to: newText)
            return false
        }
        return true
    }
}
