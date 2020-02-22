//
//  AuthViewController.swift
//  PhotoLibrary
//
//  Created by Izzatilla on 03.02.2020.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit
import GoogleSignIn
final class AuthViewController: UIViewController , AuthViewModelDelegate {

    var viewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        viewModel.delegate = self
  
    }
  
    //MARK: Actions
    
    @IBAction func signInPressed(_ sender: Any) {
        viewModel.signIn()
    }
    @IBAction func signUpPressed(_ sender: Any) {
        viewModel.signUp()
    }
    
}
