//
//  CandidateViewController.swift
//  Elections
//
//  Created by Vladimir Bulakhov on 30/04/2020.
//  Copyright © 2020 Vladimir Bulakhov. All rights reserved.
//

import UIKit
import Firebase

class CandidateViewController: UIViewController {
    
    var citizen: Citizen?
    var SelectedCanidate: Candidate?
    var uniqID = ""
    
    @IBOutlet weak var imageViewCandidate: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var textViewCandidate: UITextView!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var votedLabel: UILabel!
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageViewCandidate.image = UIImage(named: SelectedCanidate!.image)
        nameLabel.text = SelectedCanidate?.name
        textViewCandidate.text = SelectedCanidate?.description
        view.backgroundColor = .systemTeal
        textViewCandidate.backgroundColor = .systemTeal
        if citizen!.isCitizenVoted{
            button.isHidden = true
            votedLabel.isHidden = false
        } else {
            button.isHidden = false
            votedLabel.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    @IBAction func buttonTaped(_ sender: Any) {
        let alertController = UIAlertController(title: "Вы уверены?", message: "Вы точно хотите отдать голос за этого кандидата? Вы больше не сможете изменить свой выбор!", preferredStyle: .alert)
        let OkAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let self = self else { return }
            //print(self!.blockChain.chain.count)
            guard let citizen = self.citizen else { return }
            if citizen.isCitizenVoted == false {
            let ref = citizen.ref
                let post = ["name": citizen.name as Any,
                            "surname": citizen.surname as Any,
                            "numberOfPassport": citizen.numberOfPassport as Any,
                            "isCitizenVoted": true] as [String : Any]
            ref?.updateChildValues(post)
                self.uniqID = self.generateUUID()
                UserDefaults.standard.set(self.uniqID, forKey: citizen.numberOfPassport)
                
                NetworkService.sendNewTransaction(transation: Transaction(choice: self.SelectedCanidate?.shortName ?? "", uniqID: self.uniqID, date: Date().toString()))
                let alertController = UIAlertController(title: "Ваш Уникальный  ID", message: "Сохраните его чтобы в любой момент можно было проверить ваш голос", preferredStyle: .alert)
                let copyAction = UIAlertAction(title: "Скопировать", style: .default) { [weak self] _ in
                    UIPasteboard.general.string = self?.uniqID
                }
                let okAction = UIAlertAction(title: "OK", style: .default){ [weak self] _ in
                    self?.dismiss(animated: true)
                }
                alertController.addAction(copyAction)
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
                self.button.isHidden = true
                self.votedLabel.isHidden = false
                
            } else{
                print ("Вы уже голосовали")
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(OkAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    func generateUUID()-> String {
        return NSUUID().uuidString.replacingOccurrences(of: "-", with: "")
    }
    
}

extension Date {

    func toString(withFormat format: String = "yyyy-MM-dd hh:mm:ss") -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)

        return str
    }
}
