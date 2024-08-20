//
//  ViewController.swift
//  customtextfields
//
//  Created by Anastasia Tochilova  on 01.06.2024.
//

import UIKit
import SafariServices

class ViewController: UIViewController, LinkTextFieldDelegate {

    // MARK: - UI Components
    
    private let customTextField = TextFieldWithoutDigits()
    private let counterTextField = TextFieldWithCounter(maxLength: 10)
    private let maskedTextField = MaskedTextField(inputMask: "wwwww-ddddd")
    private let linkTextField = LinkTextField()
    private let passwordTextField = PasswordTextField(
        minLength: 8,
        requiresDigit: true,
        requiresLowercase: true,
        requiresUppercase: true
    )
    private let showTabBarButton = UIButton(type: .system)

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        linkTextField.linkDelegate = self
    }

    // MARK: - LinkTextFieldDelegate Method
    
    func linkTextField(_ textField: LinkTextField, didDetectValidLink url: URL) {
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }

    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .white

        customTextField.placeholder = "Custom Text Field"
        counterTextField.placeholder = "Counter Text Field"
        maskedTextField.placeholder = "Masked Text Field"
        linkTextField.placeholder = "Link Text Field"
        passwordTextField.placeholder = "Password Text Field"

        showTabBarButton.setTitle("Show Tab Bar", for: .normal)
        showTabBarButton.addTarget(self, action: #selector(showTabBar), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [
            customTextField,
            counterTextField,
            maskedTextField,
            linkTextField,
            passwordTextField,
            showTabBarButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: - Actions
    
    @objc private func showTabBar() {
        let tabBarController = TabBarController()
        present(tabBarController, animated: true, completion: nil)
    }
}

// MARK: - UIApplication Extension

extension UIApplication {
    var currentWindow: UIWindow? {
        guard let windowScene = UIApplication.shared.connectedScenes
                .filter({ $0.activationState == .foregroundActive })
                .first as? UIWindowScene else {
            return nil
        }
        return windowScene.windows.first { $0.isKeyWindow }
    }
}
