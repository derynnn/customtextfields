//
//  LinkTextField.swift
//  customtextfields
//
//  Created by Anastasia Tochilova  on 01.06.2024.
//

import UIKit
import SafariServices

protocol LinkTextFieldDelegate: AnyObject {
    func linkTextField(_ textField: LinkTextField, didDetectValidLink url: URL)
}

final class LinkTextField: UITextField {

    // MARK: - Properties

    weak var linkDelegate: LinkTextFieldDelegate?

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods
    
    private func setup() {
        self.delegate = self
    }

    private func detectAndNotifyLink(in text: String) {
        let pattern = "https?://"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: text.count)
        if let _ = regex.firstMatch(in: text, options: [], range: range),
           let url = URL(string: text) {
            linkDelegate?.linkTextField(self, didDetectValidLink: url)
        }
    }
}

extension LinkTextField: UITextFieldDelegate {
    // MARK: - UITextFieldDelegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        detectAndNotifyLink(in: text)
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        detectAndNotifyLink(in: newString)
        return true
    }
}
