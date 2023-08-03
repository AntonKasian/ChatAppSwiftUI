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
    @Published var isUserCurrentlyLogedOut = false
    @Published var shouldShowNewMessageScreen = false
    @Published var shouldNavigateToChatLogView = false
    @Published var recentMessages = [RecentMessage]()
    
    init() {
        DispatchQueue.main.async {
            self.isUserCurrentlyLogedOut = FirebaseManager.shared.auth.currentUser?.uid == nil
        }
        
        fetchCurrentUser()
        
        fetchResentMessages()
    }
    
    private func fetchResentMessages() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        FirebaseManager.shared.firestore
            .collection("recent_messages")
            .document(uid)
            .collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error with fetchResentMessages: \(error)")
                    return
                }
                
                //Возомжно тут происходит переход на MainView после нажатитя отправить
                querySnapshot?.documentChanges.forEach({ change in
                   
                    //                    if change.type == .added {
                    let docId = change.document.documentID
                    if let index = self.recentMessages.firstIndex(where: { rm in
                        return rm.documentId == docId
                    }) {
                        self.recentMessages.remove(at: index)
                    }
                    
                    self.recentMessages.insert(.init(documentId: docId, data: change.document.data()), at: 0)
                    
                    //                    }
                })
            }
    }
    
     func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not find user"
            return
        }
    
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user. ERROR: \(error)"
                return
            }
            guard let data = snapshot?.data() else {
                print("Cannot find DATA")
                return
            }
            
            self.chatUser = .init(data: data)
        }
    }
    
    func handleSignOut() {
        isUserCurrentlyLogedOut.toggle()
        try? FirebaseManager.shared.auth.signOut()
    }
}


