//
//  LoginViewController.swift
//  PO-DO
//
//  Created by Recep Taha Aydın on 28.12.2023.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: DesignableUITextField!
    @IBOutlet weak var password: DesignableUITextField!
    
    let firestoreManager = FirestoreManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "signupVC")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    @IBAction func signInTapped(_ sender: LoaderButton) {
        let email = email.text!
        let password = password.text!
        
        sender.isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in }
                alertController.addAction(okAction)
                
                strongSelf.present(alertController, animated: true, completion: nil)
                
                sender.isLoading = false
                return
            }
            
            sender.isLoading = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController
                vc?.modalPresentationStyle = .fullScreen
                self!.present(vc!, animated: false)
            }
        }
    }
}
