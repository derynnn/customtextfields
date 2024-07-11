//
//  MaskedTextField.swift
//  customtextfields
//
//  Created by Anastasia Tochilova  on 01.06.2024.
//

import UIKit

class MaskedTextField: UITextField, UITextFieldDelegate {
    private let inputMask: String

    init(inputMask: String) {
        self.inputMask = inputMask
        super.init(frame: .zero)
        self.delegate = self
    }

    required init?(coder: NSCoder) {
        self.inputMask = "wwwww-ddddd"
        super.init(coder: coder)
        self.delegate = self
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let maskedText = applyMask(text: newText)
        textField.text = maskedText
        return false
    }

    private func applyMask(text: String) -> String {
        let allowedCharacters = CharacterSet.letters.union(.decimalDigits)
        let filteredText = text.filter { char in
            allowedCharacters.contains(char.unicodeScalars.first!)
        }

        var formattedText = ""
        var index = 0
        for char in inputMask {
            if index < filteredText.count {
                let filteredIndex = filteredText.index(filteredText.startIndex, offsetBy: index)
                if char == "w" {
                    if filteredText[filteredIndex].isLetter {
                        formattedText.append(filteredText[filteredIndex])
                        index += 1
                    } else {
                        break
                    }
                } else if char == "d" {
                    if filteredText[filteredIndex].isNumber {
                        formattedText.append(filteredText[filteredIndex])
                        index += 1
                    } else {
                        break
                    }
                } else {
                    formattedText.append(char)
                }
            } else {
                formattedText.append(char)
            }
        }

        return formattedText
    }
}
