//
//  SignupViewController.swift
//  PO-DO
//
//  Created by Recep Taha Aydın on 27.12.2023.
//

import UIKit
import FirebaseAuth

class SignupViewController: UIViewController {
    
    @IBOutlet weak var email: DesignableUITextField!
    @IBOutlet weak var password: DesignableUITextField!
    
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
        let email = email.text!
        let password = password.text!
        
        sender.isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                let b1 = CRXDialogButton(title: "OK", style: .default)  { print("YES") }
                DialogView(title: "Error", message: error.localizedDescription, buttons: [b1]).show()
                sender.isLoading = false
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                sender.isLoading = false
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController
                vc?.modalPresentationStyle = .fullScreen
                self.present(vc!, animated: true)
            }
        }
    }
}
