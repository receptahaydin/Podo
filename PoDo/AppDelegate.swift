//
//  AppDelegate.swift
//  PoDo
//
//  Created by Recep Taha Aydın on 9.01.2024.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        let splashVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "splashVC") as! SplashViewController
        self.window?.rootViewController = splashVC
        self.window?.makeKeyAndVisible()
        
        configureKeyboardManager()
        
        return true
    }
    
    private func configureKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Done"
        IQKeyboardManager.shared.placeholderFont = .regular(size: 14)
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.disabledTouchResignedClasses = []
        IQKeyboardManager.shared.disabledToolbarClasses =  []
        IQKeyboardManager.shared.disabledDistanceHandlingClasses = []
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
