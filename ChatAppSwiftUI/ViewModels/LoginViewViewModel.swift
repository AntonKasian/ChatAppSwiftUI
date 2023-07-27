//
//  LoginViewViewModel.swift
//  ChatAppSwiftUI
//
//  Created by Anton on 27.07.23.
//

import Foundation
import SwiftUI

class LoginViewViewModel: ObservableObject {
    
    @Published var isLogInMode = false
    @Published var email = ""
    @Published var password = ""
    @Published var shouldShowImagePicker = false
    @Published var loginStatusMessage = ""
    @Published var image: UIImage?
    
    init() {}
    
     func handlerAction() {
        if isLogInMode {
            loginUser()
           print("Login")
        } else {
            createNewAccount()
            print("Create account")
        }
    }
    
     func createNewAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) {result, error in
            if let error = error {
                print("Failed to create user", error)
                self.loginStatusMessage = "Failed to create user \(error)"
                return
            }
            
            print("Successfully created user: \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
        }
    }
    
    private func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to login user", error)
                self.loginStatusMessage = "Failed to login user \(error)"
                return
            }
            
            print("Successfully loged in as user: \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Successfully loged in as user: \(result?.user.uid ?? "")"
        }
    }

}
