//
//  LoginViewViewModel.swift
//  ChatAppSwiftUI
//
//  Created by Anton on 27.07.23.
//

import Foundation
import SwiftUI
import Firebase

class LoginViewViewModel: ObservableObject {
    
    @Published var isLogInMode = false
    @Published var email = ""
    @Published var password = ""
    @Published var shouldShowImagePicker = false
    @Published var loginStatusMessage = ""
    @Published var image: UIImage?
    @Published var uploadProgress: Double = 0.0

    
    init() {}
    
     func handlerAction() {
        if isLogInMode {
            DispatchQueue.main.async {
                self.loginUser()
            }
            //loginUser()
           print("Login")
        } else {
            DispatchQueue.main.async {
                self.createNewAccount()
            }
//            createNewAccount()
            print("Create account")
        }
    }
    
     private func createNewAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) {result, error in
            if let error = error {
                print("Failed to create user", error)
                self.loginStatusMessage = "Failed to create user \(error)"
                return
            }
            
            print("Successfully created user: \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
            
            // Download image to Firebase
            
            self.persistImageToStorage()
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
    
    private func persistImageToStorage() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else { return }
        
        ref.putData(imageData) { metadata, error in
            if let error = error {
                self.loginStatusMessage = "Failed to push image to storage: \(error)"
                return
            }
            
            ref.downloadURL { url, error in
                if let error = error {
                    self.loginStatusMessage = "Failed to retrieve download URL: \(error)"
                    return
                }
                
                self.loginStatusMessage = "Successfully stored image with url: \(url?.absoluteString ?? "")"
                print("\(url?.absoluteString ?? "")")
            }
        }
    }

}
