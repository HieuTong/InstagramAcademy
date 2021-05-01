//
//  LoginViewController.swift
//  InstagramAcademy
//
//  Created by HieuTong on 5/1/21.
//

import UIKit

class LoginViewController: UIViewController {

    private let usernameEmailTextField: UITextField = {
        return UITextField()
    }()
    
    private let passwordField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let loginButton: UIButton = {
        return UIButton()
    }()
    
    private let termButton: UIButton = {
        return UIButton()
    }()
    
    private let privacyButton: UIButton = {
        return UIButton()
    }()
    
    private let createAccountButton: UIButton = {
        return UIButton()
    }()
    
    private let headerView: UIView = {
        return UIView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //assign frames
        headerView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.size.width, height: 200)
    }
    
    private func addSubviews() {
        view.addSubview(usernameEmailTextField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
    }

    @objc private func didTapLoginButton() {
        
    }
    
    @objc private func didTapTermButton() {
        
    }
    
    @objc private func didTapPrivacyButton() {
        
    }
    
    @objc private func didTapCreateAccountButton() {
        
    }
}
