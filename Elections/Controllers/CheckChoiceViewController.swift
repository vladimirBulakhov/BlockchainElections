//
//  CheckChoiceViewController.swift
//  Elections
//
//  Created by Vladimir Bulakhov on 07.01.2022.
//  Copyright © 2022 Vladimir Bulakhov. All rights reserved.
//

import UIKit

class CheckChoiceViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var hashTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    var hasID: Bool { isLoggedIn && (UserDefaults.standard.string(forKey: citizenId ?? "") != nil)  }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if hasID {
            label.text = "Нажмите на кнопку проверить, чтобы произвести проверку вашего голоса"
            hashTextField.isHidden = true
        } else {
            label.text = "Введите уникальный индетификатор вашего блока"
            hashTextField.isHidden = false
        }
    }
    
    @objc func buttonTapped() {
        if hasID {
            guard let id = UserDefaults.standard.string(forKey: citizenId ?? "") else { return }
            checkID(id: id)
        } else {
            checkID(id: hashTextField.text ?? "")
        }
    }
    
    func checkID(id: String) {
        NetworkService.checkHash(uniqID: id) { (transaction) in
            DispatchQueue.main.async {
                let message: String
                if let transaction = transaction {
                    message = "Дата: \(transaction.date) \n Выбор: \(transaction.choice)"
                } else {
                    message = "Упс, что - то пошло не так!"
                }
                let controller = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(controller, animated: true)
            }
        }
    }

}
