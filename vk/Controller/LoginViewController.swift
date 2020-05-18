//
//  ViewController.swift
//  vk
//
//  Created by Rafael Khanov on 18.10.2019.
//  Copyright © 2019 Rafael Khanov. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var vkLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func loginButton(_ sender: Any) {
        if userNameTextField.text == "" && userPasswordTextField.text == "" {
            performSegue(withIdentifier: "Login Segue", sender: "nil")
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Введены неверные данные",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(willTapped))
        view.addGestureRecognizer(tapGR)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func willShowKeyboard(_ notification: Notification) {
        
        guard let info = notification.userInfo as NSDictionary?,
            let keyboardSize = info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as?
            NSValue else { return }
        
        let keyboardHight = keyboardSize.cgRectValue.size.height
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHight, right: 0)
    }
    @objc func willHideKeyboard(_ notification: Notification) {
        scrollView.contentInset = .zero
    }
    @objc func willTapped() {
        view.endEditing(true)
    }
}

