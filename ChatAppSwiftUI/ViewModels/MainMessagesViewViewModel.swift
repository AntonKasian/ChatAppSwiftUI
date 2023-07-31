//
//  MainMessagesViewViewModel.swift
//  ChatAppSwiftUI
//
//  Created by Anton on 31.07.23.
//

import SwiftUI

class MainMessagesViewViewModel: ObservableObject {
    
    @Published var shouldShowLogOutOptions = false
    @Published var errorMessage = ""
    @Published var chatUser: ChatUser?
    
    init() {
        fetchCurrentUser()
    }
    
    private func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not find user"
            return
        }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user. ERROR: \(error)"
                return
            }
            guard let data = snapshot?.data() else { return }
//            print(data)
           // self.errorMessage = "\(data)"
            let uid = data["uid"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let profileImageURL = data["profileImageURL"] as? String ?? ""
            self.chatUser = ChatUser(uid: uid, email: email, profileImageURL: profileImageURL)
            
//            self.errorMessage = chatUser.profileImageURL
        }
    }
}


