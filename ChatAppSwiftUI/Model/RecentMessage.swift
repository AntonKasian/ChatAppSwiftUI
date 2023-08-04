//
//  RecentMessage.swift
//  ChatAppSwiftUI
//
//  Created by Anton on 03.08.23.
//

import SwiftUI
import Firebase

struct RecentMessage: Identifiable {
    
    var id: String {
        documentId
    }
    
    let documentId: String
    let text, email: String
    let fromId, toId: String
    let profileImageURL: String
    let timestamp: Timestamp
    
    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        self.text = data[FirebaseConstants.text] as? String ?? ""
        self.email = data[FirebaseConstants.email] as? String ?? ""
        self.fromId = data[FirebaseConstants.fromId] as? String ?? ""
        self.toId = data[FirebaseConstants.toId] as? String ?? ""
        self.profileImageURL = data[FirebaseConstants.profileImageURL] as? String ?? ""
        self.timestamp = data[FirebaseConstants.timestamp] as? Timestamp ?? Timestamp(date: Date())
    }
}
