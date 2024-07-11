//
//  LinkTextField.swift
//  customtextfields
//
//  Created by Anastasia Tochilova  on 01.06.2024.
//

import UIKit
import SafariServices

class LinkTextField: UITextField, UITextFieldDelegate {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        self.keyboardType = .URL
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.delegate = self
        self.keyboardType = .URL
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        handleLink(newText)
        return true
    }

    private func handleLink(_ text: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if text.starts(with: "http"), let url = URL(string: text) {
                self.openLink(url)
            }
        }
    }

    private func openLink(_ url: URL) {
        let safariVC = SFSafariViewController(url: url)
        if let rootVC = UIApplication.shared.currentWindow?.rootViewController {
            rootVC.present(safariVC, animated: true, completion: nil)
        }
    }
}
