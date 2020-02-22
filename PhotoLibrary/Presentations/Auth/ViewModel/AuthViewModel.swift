//
//  AuthViewModel.swift
//  PhotoLibrary
//
//  Created by Izzatilla on 03.02.2020.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation
import GoogleSignIn

protocol AuthViewModelDelegate: class {
    
}

final class AuthViewModel {
    weak var delegate: AuthViewModelDelegate?
    
    func signIn() {
        GIDSignIn.sharedInstance()?.scopes = ["https://www.googleapis.com/auth/photoslibrary.readonly", "https://www.googleapis.com/auth/photoslibrary", "https://www.googleapis.com/auth/photoslibrary.readonly.appcreateddata"]
        GIDSignIn.sharedInstance()?.signIn()
        
    }
    
    func signUp() {
        if let url = URL(string: "https://accounts.google.com/signup") {
            UIApplication.shared.open(url)
        }
    }
    
}
