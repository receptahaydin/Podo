//
//  SettingsViewController.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 12.01.2024.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func logOutTapped(_ sender: LoaderButton) {
        sender.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "loginVC")

            if let sceneDelegate = UIApplication.shared.connectedScenes
                .first(where: { $0.delegate is SceneDelegate })?.delegate as? SceneDelegate,
                let window = sceneDelegate.window {
                
                UIView.transition(with: window, duration: 0.5, options: .transitionCurlUp, animations: {
                    window.rootViewController = vc
                }, completion: nil)
            }
        }
    }
}
