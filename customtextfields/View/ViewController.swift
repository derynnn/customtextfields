//
//  ViewController.swift
//  customtextfields
//
//  Created by Anastasia Tochilova  on 01.06.2024.
//

import UIKit

class ViewController: UIViewController {

    private let customTextField = CustomTextField()
    private let counterTextField = CounterTextField(maxLength: 10)
    private let maskedTextField = MaskedTextField(inputMask: "wwwww-ddddd")
    private let linkTextField = LinkTextField()
    private let passwordTextField = PasswordTextField()
    private lazy var showTabBarButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Tab Bar", for: .normal)
        button.addTarget(self, action: #selector(showTabBar), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white

        let stackView = UIStackView(arrangedSubviews: [
            customTextField,
            counterTextField,
            maskedTextField,
            linkTextField,
            passwordTextField
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        view.addSubview(showTabBarButton)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            showTabBarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showTabBarButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    @objc private func showTabBar() {
        let tabBarController = TabBarController()
        navigationController?.pushViewController(tabBarController, animated: true)
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
