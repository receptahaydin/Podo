//
//  SignupViewController.swift
//  PO-DO
//
//  Created by Recep Taha Aydın on 27.12.2023.
//

import UIKit
import FirebaseAuth

class SignupViewController: UIViewController {
    
    @IBOutlet weak var name: DesignableUITextField!
    @IBOutlet weak var email: DesignableUITextField!
    @IBOutlet weak var password: DesignableUITextField!
    
    let firestoreManager = FirestoreManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "loginVC")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    @IBAction func buttonTapped(_ sender: LoaderButton) {
        let name = name.text!
        let email = email.text!
        let password = password.text!
        
        guard !name.isEmpty else {
            let alertController = UIAlertController(title: "Error", message: "Please enter your name.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in }
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true)
            
            return
        }
        
        sender.isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in }
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true)
                
                sender.isLoading = false
                return
            }
            
            let userData: [String: Any] = [
                "country": "",
                "countryCode": "",
                "email": email,
                "name": name,
                "phoneNumber": "",
            ]
            
            let user = User(data: userData)
            self.firestoreManager.addUser(user: user)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController
                vc?.modalPresentationStyle = .fullScreen
                self.present(vc!, animated: false)
            }
        }
    }
}

