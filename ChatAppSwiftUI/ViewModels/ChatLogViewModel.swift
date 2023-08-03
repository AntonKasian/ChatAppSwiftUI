//
//  ChatLogViewModel.swift
//  ChatAppSwiftUI
//
//  Created by Anton on 02.08.23.
//

import Foundation
import Firebase

class ChatLogViewModel: ObservableObject {
    @Published var chatText = ""
    @Published var chatMessages = [ChatMessage]()
    
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        fetchMessages()
    }
    
    private func fetchMessages() {
        guard let fromId = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let toId = chatUser?.uid else { return }
        
        FirebaseManager.shared.firestore
            .collection("messages")
            .document(fromId)
            .collection(toId)
            .order(by: "timestamp")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error with querySnapshot: \(error)")
                    return
                }
                
                querySnapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        let data = change.document.data()
                        self.chatMessages.append(.init(documentId: change.document.documentID, data: data))
                    }
                })
            }
    }
    
    func handleSend() {
        print(chatText)
        
        guard let fromId = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        guard let toId = chatUser?.uid else { return }
        
        let document = FirebaseManager.shared.firestore
            .collection("messages")
            .document(fromId)
            .collection(toId)
            .document()
        
        let messageData = [FirebaseConstants.fromId: fromId,
                           FirebaseConstants.toId: toId,
                           FirebaseConstants.text: self.chatText,
                           "timestamp": Timestamp()] as [String : Any]
        
        document.setData(messageData) {error in
            if let error = error {
                print(error)
                print("Failed to save message into Firestore: \(error)")
                return
            }
            print("Save in Firestore current user sending message")
            self.chatText = ""
        }
        
        let recipientMessageDocument = FirebaseManager.shared.firestore
            .collection("messages")
            .document(toId)
            .collection(fromId)
            .document()
        
        recipientMessageDocument.setData(messageData) {error in
            if let error = error {
                print(error)
                print("Failed to save message into Firestore: \(error)")
                return
            }
            print("Recipient saved message as well")
        }
    }
}
