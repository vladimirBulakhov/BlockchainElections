//
//  LoginViewController.swift
//  Elections
//
//  Created by Vladimir Bulakhov on 02/05/2020.
//  Copyright © 2020 Vladimir Bulakhov. All rights reserved.
//

/*
Для входа name: "Александр", surname: "Андрющенко", numberOfPassport: "0003" пользователь еще не голосовал
Для входа name: "Владимир", surname: "Булахов", numberOfPassport: "0000" пользователь уже проголосовал

*/

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var surnameTF: UITextField!
    
    @IBOutlet weak var NumberOfPassport: UITextField!
    
    @IBOutlet weak var button: UIButton!
    
    
    var ref: DatabaseReference!
    var citizen: Citizen?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference().child("citizens")
        button.layer.cornerRadius = 5
        /*NetworkService.getBlockChain { (Blockchain) in
            print(Blockchain)
        }*/
        //var newCitizen = Citizen(name: "Александр", surname: "Андрющенко", numberOfPassport: "0003")
        //newCitizen.ref = ref.child(newCitizen.numberOfPassport.lowercased())
        //newCitizen.ref?.setValue(newCitizen.convertToDictionary())
        
    }
    

    @IBAction func ButtonTapped(_ sender: Any) {
        
        if NumberOfPassport.text != ""{
            ref = Database.database().reference().child("citizens")
            ref = ref.child(String(NumberOfPassport.text!))
            ref.observe(DataEventType.value, with: { (snapshot) in
                let snapshotValue = snapshot.value as? [String : AnyObject] ?? [:]
                guard let name = snapshotValue["name"],let surname = snapshotValue["surname"],let numberOfPassport = snapshotValue["numberOfPassport"], let vote = snapshotValue["isCitizenVoted"] else {
                    let alertController = UIAlertController(title: "Ошибка", message: "Ошибка при вводе логина и/или пароля", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK!", style: .default)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true)
                    return
                }
                let nameOfCitizen = name as! String
                let surnameOfCitizen = surname as! String
                let numberOfPasspot = numberOfPassport as! String
                let isVoted = vote as! Bool
                
                let citizen = Citizen(name: nameOfCitizen, surname: surnameOfCitizen, numberOfPassport: numberOfPasspot, isCitizenVoted: isVoted, ref: self.ref)
                self.citizen = citizen
                let nameTF = self.nameTF?.text
                let surnameTF = self.surnameTF?.text
                let numberTF = self.NumberOfPassport.text
                let newCitizen = Citizen(name: nameTF!, surname: surnameTF!, numberOfPassport: numberTF!)
                isLoggedIn = true
                citizenId = numberTF
                print(newCitizen)
                if self.citizen!.name == newCitizen.name && self.citizen!.surname == newCitizen.surname && self.citizen!.numberOfPassport == newCitizen.numberOfPassport{
                    
                    self.performSegue(withIdentifier: "firstSegue", sender: self)
                }
            })
        } else {
            let alertController = UIAlertController(title: "Ошибка", message: "Ошибка при вводе логина и/или пароля", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK!", style: .default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
        }
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "firstSegue"{
            let vc = segue.destination as! CollectionViewController
            vc.citizen = citizen
        }
    }
    
}

var isLoggedIn = false
var citizenId: String?
