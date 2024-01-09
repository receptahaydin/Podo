//
//  SplashViewController.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 9.01.2024.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "onboardingVC")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
    }
}
