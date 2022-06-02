//
//  LoginViewController.swift
//  FunZone
//
//  Created by admin on 5/27/22.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var rememberMeToggle: UISwitch!
    let userDefault = UserDefaults.standard
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        if userDefault.string(forKey: "rememberMe") == "yes"{
            rememberMeToggle.setOn(true, animated: true)
            usernameField.text = userDefault.string(forKey: "userName")
            let req : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : usernameField.text!, kSecReturnAttributes as String : true, kSecReturnData as String : true]

            var res : CFTypeRef?
            if SecItemCopyMatching(req as CFDictionary, &res) == noErr{
                let data = res as? [String : Any]
                let userPassword = (data![kSecValueData as String] as? Data)!
                let pass = String(data: userPassword, encoding: .utf8)
                passwordField.text = pass
            }
        }
        
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func loginButton(_ sender: Any) {
        let req : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : usernameField.text!, kSecReturnAttributes as String : true, kSecReturnData as String : true]
        
        var res : CFTypeRef?
        if SecItemCopyMatching(req as CFDictionary, &res) == noErr{
            let data = res as? [String : Any]
            let userName = (data![kSecAttrAccount as String]  as? String)!
            let userPassword = (data![kSecValueData as String] as? Data)!
            let pass = String(data: userPassword, encoding: .utf8)
            if passwordField.text == pass{
                userDefault.set(userName, forKey: "currentLoggedIn")
                if(rememberMeToggle.isOn){
                    userDefault.set("yes", forKey: "rememberMe")
                    userDefault.set(userName, forKey: "userName")
                }else{
                    userDefault.set("no", forKey: "rememberMe")
                    userDefault.set("", forKey: "pass")
                    userDefault.set("", forKey: "userName")
                }
                createUser(userName)
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let page = storyBoard.instantiateViewController(withIdentifier: "tabController")
                show(page, sender: Any?.self)
            }
            
        }else{
            let defaultAction = UIAlertAction(title: "Ok", style: .default){(action) in}
            let alert = UIAlertController(title: "Error", message: "An error has occurred", preferredStyle: .alert)
            alert.addAction(defaultAction)
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func signupButton(_ sender: Any) {
        let attribute : [String : Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrAccount as String : usernameField.text!, kSecValueData as String : passwordField.text!.data(using: .utf8)!]
        if SecItemAdd(attribute as CFDictionary, nil) == noErr {
            let defaultAction = UIAlertAction(title: "Ok", style: .default){(action) in}
            let alert = UIAlertController(title: "Sign up Successful", message: "Please log in with your credentials", preferredStyle: .alert)
            alert.addAction(defaultAction)
            self.present(alert, animated: true)
        }else{
            let defaultAction = UIAlertAction(title: "Ok", style: .default){(action) in}
            let alert = UIAlertController(title: "Error", message: "An error has occurred", preferredStyle: .alert)
            alert.addAction(defaultAction)
            self.present(alert, animated: true)
        }
    }
    func createUser(_ userName: String){
        do{
            let request = User.fetchRequest() as NSFetchRequest<User>
            let pred = NSPredicate(format: "name == %@", userName)
            request.predicate = pred
            let userArr = try context.fetch(request)
            let user = userArr.first
            if (user?.name != nil) {
                return
            }else{
                let newUser = User(context: context)
                newUser.name = userName
                do{
                    try context.save()
                }catch{
                    print("error saving User")
                }
            }
        }catch{
            print("Error fetching user")
        }
    }
}

