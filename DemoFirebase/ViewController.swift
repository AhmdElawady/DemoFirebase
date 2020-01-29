//
//  ViewController.swift
//  DemoFirebase
//
//  Created by Awady on 1/22/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseUI


class ViewController: UIViewController, FUIAuthDelegate {
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    var authUI: FUIAuth?
    var ref: DatabaseReference?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        let providers: [FUIAuthProvider] = [FUIGoogleAuth()]
        authUI?.providers = providers
        
        ref = Database.database().reference()
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if error == nil {
            loginButton.setTitle("Logout", for: .normal)
        }
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        if Auth.auth().currentUser == nil {
            if let authVC = authUI?.authViewController() {
                present(authVC, animated: true, completion: nil)
            }
//            if let email = emailTxtField.text, let password = passwordTxtField.text {
//                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
//                    if error == nil {
//                        self.loginButton.setTitle("Logout", for: .normal)
//                    }
//                }
//            }
        } else {
            do {
                try Auth.auth().signOut()
                self.loginButton.setTitle("Login", for: .normal)
            }
            catch {}
        }
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        if let email = emailTxtField.text, let password = passwordTxtField.text {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                print(user?.user.email ?? "No Email")
                print(user?.user.uid ?? "No Uid")
                
                print(Auth.auth().currentUser?.email ?? "No email")
                print(Auth.auth().currentUser?.uid ?? "No uid")
            }
        }
    }
    
}

